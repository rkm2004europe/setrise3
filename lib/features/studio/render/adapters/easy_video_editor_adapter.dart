library;

import 'dart:async';

import 'package:easy_video_editor/easy_video_editor.dart';

import '../../entities/layer.dart';
import '../../entities/project.dart';
import '../../render/render_pipeline.dart';

class EasyVideoEditorAdapter implements RenderAdapter {
  @override
  String get id => 'easy_video_editor';

  @override
  bool supports(StudioProject project) {
    final videoLayers = project.layers.whereType<VideoLayer>().toList();
    if (videoLayers.length != 1) return false;
    final audioLayers = project.layers.whereType<AudioLayer>().toList();
    return audioLayers.isEmpty;
  }

  @override
  Future<String> render(
    RenderJob job, {
    required void Function(RenderProgress) onProgress,
    required CancellationToken cancellationToken,
  }) async {
    final videoLayer = job.project.layers.whereType<VideoLayer>().first;
    final source = job.project.sourceById(videoLayer.source);
    final path = source?.mapOrNull(file: (s) => s.path);
    if (path == null) {
      throw StateError('Video source is not a local file');
    }

    final builder = VideoEditorBuilder(videoPath: path)
      ..trim(
        startTimeMs: videoLayer.sourceStart ~/ 1000,
        endTimeMs: (videoLayer.sourceStart + videoLayer.duration) ~/ 1000,
      )
      ..speed(speed: videoLayer.speed);

    if (videoLayer.volume == 0) {
      builder.removeAudio();
    }

    final outputPath = job.outputPath;

    final result = await builder.export(
      outputPath: outputPath,
      onProgress: (p) {
        if (cancellationToken.isCancelled) return;
        onProgress(RenderProgress(
          fraction: p,
          currentFrame: 0,
          totalFrames: 0,
          stage: Stage.encoding,
        ));
      },
    );

    if (cancellationToken.isCancelled) {
      throw StateError('Render cancelled');
    }
    return result;
  }
}
