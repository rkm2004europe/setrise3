library;

import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:ffmpeg_kit_flutter_new/statistics.dart';

import '../../entities/layer.dart';
import '../../entities/project.dart';
import '../../export/export_settings.dart';
import '../../render/render_pipeline.dart';
import '../../utils/typedefs.dart';

/// Transitions supported by FFmpeg's xfade filter.
enum FFmpegTransition {
  fade, wipeleft, wiperight, wipeup, wipedown,
  slideleft, slideright, slideup, slidedown,
  circlecrop, rectcrop, distance, fadeblack, fadewhite,
  radial, dissolve, pixelize, zoomin, hblur,
}

class FFmpegRenderAdapter implements RenderAdapter {
  FFmpegRenderAdapter({this.enableHwAccel = true, this.preset = 'medium'});

  final bool enableHwAccel;
  final String preset;

  @override
  String get id => 'ffmpeg';

  @override
  bool supports(StudioProject project) {
    final videoLayers = project.layers.whereType<VideoLayer>().toList();
    final audioLayers = project.layers.whereType<AudioLayer>().toList();
    final hasOverlays = project.layers.any(
      (l) =>
          l is TextLayer ||
          l is ImageLayer ||
          l is StickerLayer ||
          l is EffectLayer,
    );
    return videoLayers.length > 1 ||
        audioLayers.isNotEmpty ||
        hasOverlays;
  }

  @override
  Future<String> render(
    RenderJob job, {
    required void Function(RenderProgress) onProgress,
    required CancellationToken cancellationToken,
  }) async {
    final outputPath = job.outputPath;
    final project = job.project;
    final settings = job.settings;

    FFmpegKitConfig.ignoreSignal(15);
    var currentSessionId = -1;

    final cmd = _buildCommand(project, settings, outputPath);
    final session = await FFmpegKit.executeAsync(
      cmd,
      (session) async {},
      (log) {},
      (Statistics stats) {
        final fraction = stats.getTime() > 0
            ? (stats.getTime() / project.totalDuration.seconds / 1000)
                .clamp(0.0, 1.0)
            : 0.0;
        onProgress(RenderProgress(
          fraction: fraction,
          currentFrame: stats.getVideoFrameNumber(),
          totalFrames: 0,
          stage: Stage.encoding,
        ));
      },
    );
    currentSessionId = await session.getSessionId();

    if (cancellationToken.isCancelled) {
      await FFmpegKit.cancel(currentSessionId);
      throw StateError('Render cancelled');
    }

    final rc = await session.getReturnCode();
    if (!ReturnCode.isSuccess(rc)) {
      final logs = await session.getAllLogsAsString();
      throw StateError('FFmpeg failed (rc=${rc?.getValue()}): $logs');
    }

    return outputPath;
  }

  /// Build the FFmpeg command for [project].
  String _buildCommand(
    StudioProject project,
    ExportSettings settings,
    String outputPath,
  ) {
    final inputs = <String>[];
    final filterParts = <String>[];

    final layers = project.layers;
    final videoLayers = layers.whereType<VideoLayer>().toList();
    final imageLayers = layers.whereType<ImageLayer>().toList();
    final textLayers = layers.whereType<TextLayer>().toList();
    final audioLayers = layers.whereType<AudioLayer>().toList();

    // ── Collect inputs ────────────────────────────────────────────────────
    for (final v in videoLayers) {
      final path = v.source.mapOrNull(file: (s) => s.path);
      if (path != null) inputs.add('-i "$path"');
    }
    for (final img in imageLayers) {
      final path = img.source.mapOrNull(file: (s) => s.path);
      if (path != null) inputs.add('-i "$path"');
    }
    for (final a in audioLayers) {
      final path = a.source.mapOrNull(file: (s) => s.path);
      if (path != null) inputs.add('-i "$path"');
    }

    // ── Build filter graph ────────────────────────────────────────────────
    final canvasW =
        (project.targetHeight * project.aspectRatio.ratio).round();
    final canvasH = project.targetHeight;

    // Get the color filter to apply (if any).
    final filterId = settings.filterId;
    final colorFilterChain = _buildColorFilterChain(filterId);

    // Step 1: scale the first video to canvas, mark as [base].
    if (videoLayers.isNotEmpty) {
      final trimStart = videoLayers.first.sourceStart ~/ 1000;
      final trimEnd =
          (videoLayers.first.sourceStart + videoLayers.first.duration) ~/
              1000;
      filterParts.add(
        '[0:v]trim=$trimStart:$trimEnd,setpts=PTS-STARTPTS,'
        'scale=$canvasW:$canvasH:force_original_aspect_ratio=increase,'
        'crop=$canvasW:$canvasH,setsar=1$colorFilterChain[base]',
      );
    } else {
      filterParts.add(
        'color=c=black:s=${canvasW}x$canvasH:d=${project.totalDuration.seconds}[base]',
      );
    }

    // Step 2: overlay each subsequent video layer.
    var lastVideoLabel = 'base';
    var inputIdx = 1;
    for (var i = 1; i < videoLayers.length; i++) {
      final v = videoLayers[i];
      final trimStart = v.sourceStart ~/ 1000;
      final trimEnd = (v.sourceStart + v.duration) ~/ 1000;
      final outLabel = 'v$i';
      filterParts.add(
        '[$inputIdx:v]trim=$trimStart:$trimEnd,setpts=PTS-STARTPTS,'
        'scale=${(v.transform.scale * canvasW).round()}:'
        '${(v.transform.scale * canvasH).round()},'
        'format=rgba,colorchannelmixer=aa=${v.transform.opacity}[fg$i]',
      );
      final x = (v.transform.position.dx * canvasW).round();
      final y = (v.transform.position.dy * canvasH).round();
      final delayMs = v.startMicroseconds ~/ 1000;
      filterParts.add(
        '[$lastVideoLabel][fg$i]overlay=$x:$y:delay=$delayMs:eof_action=pass[$outLabel]',
      );
      lastVideoLabel = outLabel;
      inputIdx++;
    }

    // Step 3: overlay image layers.
    for (var i = 0; i < imageLayers.length; i++) {
      final img = imageLayers[i];
      final outLabel = 'img$i';
      filterParts.add(
        '[$inputIdx:v]scale=${(img.transform.scale * canvasW).round()}:'
        '${(img.transform.scale * canvasH).round()},format=rgba,'
        'colorchannelmixer=aa=${img.transform.opacity}[fgimg$i]',
      );
      final x = (img.transform.position.dx * canvasW).round();
      final y = (img.transform.position.dy * canvasH).round();
      final delayMs = img.startMicroseconds ~/ 1000;
      filterParts.add(
        '[$lastVideoLabel][fgimg$i]overlay=$x:$y:delay=$delayMs:eof_action=pass[$outLabel]',
      );
      lastVideoLabel = outLabel;
      inputIdx++;
    }

    // Step 4: burn in text layers via drawtext.
    for (var i = 0; i < textLayers.length; i++) {
      final t = textLayers[i];
      final escapedText = _escapeDrawtext(t.text);
      final fontSize = (t.preset.fontSize * canvasH / 1920).round();
      final x = '(w-text_w)/2';
      final y = (t.transform.position.dy * canvasH).round();
      final enable =
          'between(t,${t.startMicroseconds / 1000000},${t.endMicroseconds / 1000000})';
      final strokeW = t.preset.strokeWidth;
      final outLabel = 'txt$i';
      filterParts.add(
        '[$lastVideoLabel]drawtext=text=\'$escapedText\':'
        'fontcolor=${_colorToHex(t.preset.color)}:'
        'fontsize=$fontSize:x=$x:y=$y:'
        'bordercolor=${_colorToHex(t.preset.strokeColor)}:borderw=$strokeW:'
        'enable=\'$enable\'[$outLabel]',
      );
      lastVideoLabel = outLabel;
    }

    // Step 5: mix audio from all audio layers.
    if (audioLayers.isNotEmpty) {
      for (var i = 0; i < audioLayers.length; i++) {
        final a = audioLayers[i];
        final trimStart = a.sourceStart ~/ 1000;
        final trimEnd = (a.sourceStart + a.duration) ~/ 1000;
        final delayMs = a.startMicroseconds ~/ 1000;
        final vol = a.volume;
        filterParts.add(
          '[$inputIdx:a]atrim=$trimStart:$trimEnd,asetpts=PTS-STARTPTS,'
          'adelay=$delayMs|$delayMs,volume=$vol[aud$i]',
        );
        inputIdx++;
      }
      final amixInputs = List.generate(
        audioLayers.length,
        (i) => '[aud$i]',
      ).join('');
      filterParts.add(
        '$amixInputs amix=inputs=${audioLayers.length}:duration=longest[mixed_audio]',
      );
    }

    final filterGraph = filterParts.join(';');

    // ── Build final command ───────────────────────────────────────────────
    final videoCodec = enableHwAccel
        ? (Platform.isIOS ? 'h264_videotoolbox' : 'h264_mediacodec')
        : 'libx264';
    const audioCodec = 'aac';
    final crf = settings.quality == ExportQuality.draft ? '28' : '23';
    final bitrate = '${settings.videoBitrateMbps}M';

    return [
      '-y',
      ...inputs,
      '-filter_complex', '"$filterGraph"',
      '-map', '[$lastVideoLabel]',
      if (audioLayers.isNotEmpty)
        '-map' '[mixed_audio]'
      else if (videoLayers.isNotEmpty)
        '-map' '0:a?',
      '-c:v', videoCodec,
      if (videoCodec == 'libx264') '-preset', preset,
      if (videoCodec == 'libx264') '-crf', crf,
      '-b:v', bitrate,
      '-pix_fmt', 'yuv420p',
      '-c:a', audioCodec,
      '-b:a', '${settings.audioBitrateKbps}k',
      '-ac', '${settings.audioChannels}',
      '-ar', '${settings.audioSampleRate}',
      '-movflags', '+faststart',
      outputPath,
    ].join(' ');
  }

  String _escapeDrawtext(String text) {
    return text
        .replaceAll('\\', '\\\\')
        .replaceAll("'", "\\'")
        .replaceAll(':', '\\:')
        .replaceAll('%', '\\%');
  }

  String _colorToHex(int color) {
    final r = (color >> 16) & 0xff;
    final g = (color >> 8) & 0xff;
    final b = color & 0xff;
    return '0x${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  /// Build an FFmpeg color filter chain for the given filter ID.
  /// Returns an empty string if no filter is needed.
  String _buildColorFilterChain(String filterId) {
    switch (filterId) {
      case 'none':
        return '';
      case 'warm':
        return ',colorchannelmixer=rr=1.1:bb=0.9:gg=1.0';
      case 'cool':
        return ',colorchannelmixer=rr=0.9:bb=1.1:gg=0.95';
      case 'vivid':
        return ',eq=saturation=1.5:contrast=1.2';
      case 'sepia':
        return ',colorchannelmixer=rr=0.393:rg=0.349:rb=0.272:'
            'gr=0.769:gg=0.686:gb=0.534:'
            'br=0.189:bg=0.168:bb=0.131';
      case 'grayscale':
        return ',colorchannelmixer=rr=0.299:rg=0.299:rb=0.299:'
            'gr=0.587:gg=0.587:gb=0.587:'
            'br=0.114:bg=0.114:bb=0.114';
      case 'invert':
        return ',negate=1';
      default:
        return '';
    }
  }
}
