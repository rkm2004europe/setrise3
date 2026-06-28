library;

import 'dart:async';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

import '../entities/media_source.dart';
import '../utils/typedefs.dart';

class RecordingConfig {
  final bool enableAudio;
  final ResolutionPreset resolution;
  final SensorConfig sensor;
  final FlashMode flash;
  final Duration? maxDuration;

  const RecordingConfig({
    this.enableAudio = true,
    this.resolution = ResolutionPreset.ultra,
    this.sensor = const SensorConfig(position: SensorPosition.back),
    this.flash = FlashMode.none,
    this.maxDuration,
  });
}

class RecordingResult {
  final String filePath;
  final String mimeType;
  final Microseconds duration;
  final int width;
  final int height;
  final int sizeBytes;
  final String? thumbnailPath;

  const RecordingResult({
    required this.filePath,
    required this.mimeType,
    required this.duration,
    required this.width,
    required this.height,
    required this.sizeBytes,
    this.thumbnailPath,
  });

  MediaSourceFile toSource(String id) => MediaSourceFile(
        id: id,
        path: filePath,
        mimeType: mimeType,
        duration: duration,
        width: width,
        height: height,
        sizeBytes: sizeBytes,
        thumbnailPath: thumbnailPath,
        createdAt: DateTime.now(),
      );
}

class CameraRecorderService {
  CameraRecorderService();

  bool _isInitialised = false;
  bool _isRecording = false;
  Timer? _maxDurationTimer;
  RecordingResult? _lastResult;

  final StreamController<RecordingResult> _resultController =
      StreamController<RecordingResult>.broadcast();
  Stream<RecordingResult> get results => _resultController.stream;

  bool get isInitialised => _isInitialised;
  bool get isRecording => _isRecording;
  RecordingResult? get lastResult => _lastResult;

  Future<void> initialize() async {
    _isInitialised = true;
  }

  Future<void> startRecording(RecordingConfig config) async {
    if (_isRecording) return;
    _isRecording = true;

    if (config.maxDuration != null) {
      _maxDurationTimer = Timer(config.maxDuration!, () {
        stopRecording();
      });
    }
  }

  Future<RecordingResult?> stopRecording() async {
    if (!_isRecording) return null;
    _maxDurationTimer?.cancel();
    _isRecording = false;

    final result = _lastResult;
    if (result != null) {
      _resultController.add(result);
    }
    return result;
  }

  void onMediaCaptured(RecordingResult result) {
    _lastResult = result;
  }

  Future<void> dispose() async {
    _maxDurationTimer?.cancel();
    await _resultController.close();
  }
}
