library;

import 'dart:async';
import 'dart:io';

import 'package:flutter_whisper_kit/flutter_whisper_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../entities/layer.dart';
import '../entities/transform.dart';
import '../utils/typedefs.dart';

class WhisperSegment {
  final Microseconds start;
  final Microseconds end;
  final String text;
  final double? confidence;

  const WhisperSegment({
    required this.start,
    required this.end,
    required this.text,
    this.confidence,
  });

  Microseconds get duration => end - start;

  TextLayer toTextLayer(String trackId, StudioTextPreset preset) {
    return TextLayer(
      id: 'whisper_${start}_${text.hashCode.abs()}',
      trackId: trackId,
      text: text.trim(),
      start: start,
      duration: duration,
      transform: const StudioTransform(
        position: Offset(0.5, 0.85),
        scale: 1.0,
      ),
      preset: preset,
    );
  }
}

enum WhisperModel {
  tiny,
  base,
  small,
  medium,
  large;

  String get sizeHint => switch (this) {
        WhisperModel.tiny => '~75 MB',
        WhisperModel.base => '~150 MB',
        WhisperModel.small => '~500 MB',
        WhisperModel.medium => '~1.5 GB',
        WhisperModel.large => '~3 GB',
      };

  String get recommendation => switch (this) {
        WhisperModel.tiny => 'Real-time preview, low-end devices',
        WhisperModel.base => 'Quick drafts',
        WhisperModel.small => 'Production (recommended)',
        WhisperModel.medium => 'High-quality captioning',
        WhisperModel.large => 'Best accuracy, requires modern phone',
      };
}

class WhisperTranscriptionOptions {
  final WhisperModel model;
  final String languageCode;
  final bool translateToEnglish;
  final bool enableWordTimestamps;
  final double? temperature;

  const WhisperTranscriptionOptions({
    this.model = WhisperModel.small,
    this.languageCode = 'ar',
    this.translateToEnglish = false,
    this.enableWordTimestamps = true,
    this.temperature,
  });

  Map<String, dynamic> toMap() => {
        'model': model.name,
        'language': languageCode,
        'translate': translateToEnglish,
        'wordTimestamps': enableWordTimestamps,
        if (temperature != null) 'temperature': temperature,
      };
}

class WhisperTranscriptionService {
  WhisperTranscriptionService();

  FlutterWhisperKit? _whisper;
  bool _isInitialised = false;
  WhisperModel? _loadedModel;

  final StreamController<double> _downloadProgress =
      StreamController<double>.broadcast();
  Stream<double> get downloadProgress => _downloadProgress.stream;

  final StreamController<double> _transcriptionProgress =
      StreamController<double>.broadcast();
  Stream<double> get transcriptionProgress => _transcriptionProgress.stream;

  Future<void> initialize() async {
    if (_isInitialised) return;
    _whisper = FlutterWhisperKit();
    await _whisper!.initialize();
    _isInitialised = true;
  }

  Future<void> downloadModel(WhisperModel model) async {
    await initialize();
    _loadedModel = model;
    await _whisper!.downloadModel(
      model: model.name,
      onProgress: (progress) {
        _downloadProgress.add(progress);
      },
    );
  }

  Future<List<WhisperSegment>> transcribe(
    String audioPath,
    WhisperTranscriptionOptions options,
  ) async {
    await initialize();
    if (_loadedModel != options.model) {
      await downloadModel(options.model);
    }

    final result = await _whisper!.transcribe(
      audioPath,
      options: options.toMap(),
      onProgress: (progress) {
        _transcriptionProgress.add(progress);
      },
    );

    return _parseResult(result);
  }

  Future<List<WhisperSegment>> transcribeVideo(
    String videoPath,
    WhisperTranscriptionOptions options,
  ) async {
    final audioPath = await extractAudioFromVideo(videoPath);
    return transcribe(audioPath, options);
  }

  String toSrt(List<WhisperSegment> segments) {
    final buffer = StringBuffer();
    for (var i = 0; i < segments.length; i++) {
      final s = segments[i];
      buffer.writeln(i + 1);
      buffer.writeln('${_formatSrt(s.start)} --> ${_formatSrt(s.end)}');
      buffer.writeln(s.text.trim());
      buffer.writeln();
    }
    return buffer.toString();
  }

  String toVtt(List<WhisperSegment> segments) {
    final buffer = StringBuffer()..writeln('WEBVTT\n');
    for (final s in segments) {
      buffer.writeln('${_formatVtt(s.start)} --> ${_formatVtt(s.end)}');
      buffer.writeln(s.text.trim());
      buffer.writeln();
    }
    return buffer.toString();
  }

  List<TextLayer> toTextLayers(
    List<WhisperSegment> segments, {
    required String trackId,
    StudioTextPreset preset = StudioTextPreset.tiktokCaption,
  }) {
    return segments
        .where((s) => s.text.trim().isNotEmpty)
        .map((s) => s.toTextLayer(trackId, preset))
        .toList();
  }

  List<WhisperSegment> _parseResult(dynamic result) {
    final List<dynamic> segments;
    if (result is Map && result['segments'] is List) {
      segments = result['segments'] as List;
    } else if (result is List) {
      segments = result;
    } else {
      return const [];
    }

    return segments.map<WhisperSegment>((s) {
      final map = s as Map<String, dynamic>;
      return WhisperSegment(
        start:
            ((map['start'] as num?) ?? 0).toDouble() * 1000000 ~/ 1,
        end: ((map['end'] as num?) ?? 0).toDouble() * 1000000 ~/ 1,
        text: (map['text'] as String?) ?? '',
        confidence: (map['avgLogprob'] as num?)?.toDouble(),
      );
    }).toList();
  }

  String _formatSrt(Microseconds t) {
    final totalMs = t ~/ 1000;
    final h = (totalMs ~/ 3600000).toString().padLeft(2, '0');
    final m = ((totalMs ~/ 60000) % 60).toString().padLeft(2, '0');
    final s = ((totalMs ~/ 1000) % 60).toString().padLeft(2, '0');
    final ms = (totalMs % 1000).toString().padLeft(3, '0');
    return '$h:$m:$s,$ms';
  }

  String _formatVtt(Microseconds t) {
    return _formatSrt(t).replaceFirst(',', '.');
  }

  Future<String> extractAudioFromVideo(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    final audioPath = p.join(
      tempDir.path,
      'whisper_audio_${DateTime.now().millisecondsSinceEpoch}.wav',
    );

    try {
      final result = await Process.run('ffmpeg', [
        '-y',
        '-i', videoPath,
        '-vn',
        '-ac', '1',
        '-ar', '16000',
        '-f', 'wav',
        audioPath,
      ]);
      if (result.exitCode != 0) {
        throw StateError('FFmpeg failed: ${result.stderr}');
      }
    } on ProcessException {
      throw StateError(
        'FFmpeg not available. Wire FFmpegRenderAdapter.extractAudio() '
        'before using whisper transcription.',
      );
    }

    return audioPath;
  }

  Future<void> dispose() async {
    await _downloadProgress.close();
    await _transcriptionProgress.close();
  }
}

class WhisperLanguages {
  WhisperLanguages._();

  static const Map<String, String> supported = {
    'ar': 'العربية',
    'en': 'English',
    'zh': '中文',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'it': 'Italiano',
    'ja': '日本語',
    'ko': '한국어',
    'pt': 'Português',
    'ru': 'Русский',
    'tr': 'Türkçe',
    'hi': 'हिन्दी',
    'ur': 'اردو',
    'fa': 'فارسی',
    'he': 'עברית',
    'id': 'Bahasa Indonesia',
    'ms': 'Bahasa Melayu',
    'th': 'ภาษาไทย',
    'vi': 'Tiếng Việt',
  };
}
