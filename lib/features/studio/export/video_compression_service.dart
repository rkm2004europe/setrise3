library;

import 'dart:io';

import 'package:video_compress/video_compress.dart';

enum CompressionQuality { low, medium, high, ultra }

class CompressionResult {
  final String outputPath;
  final int originalSizeBytes;
  final int compressedSizeBytes;
  final Duration originalDuration;
  final Duration compressedDuration;
  final int? width;
  final int? height;

  const CompressionResult({
    required this.outputPath,
    required this.originalSizeBytes,
    required this.compressedSizeBytes,
    required this.originalDuration,
    required this.compressedDuration,
    this.width,
    this.height,
  });

  double get savingsPercent => 1 - (compressedSizeBytes / originalSizeBytes);

  String get savingsDescription {
    final pct = (savingsPercent * 100).round();
    return '$pct% smaller (${_formatBytes(originalSizeBytes)} → ${_formatBytes(compressedSizeBytes)})';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}

class VideoCompressionService {
  VideoCompressionService();

  bool _isInitialised = false;

  Future<void> initialize() async {
    if (_isInitialised) return;
    VideoCompress.setLogLevel(LogLevel.warning);
    _isInitialised = true;
  }

  Future<CompressionResult> compress({
    required String inputPath,
    CompressionQuality quality = CompressionQuality.medium,
    bool deleteOriginal = false,
    bool includeAudio = true,
    int? frameRate,
    int? startTimeMs,
    int? durationMs,
  }) async {
    await initialize();

    final qualityValue = switch (quality) {
      CompressionQuality.low => VideoQuality.LowQuality,
      CompressionQuality.medium => VideoQuality.DefaultQuality,
      CompressionQuality.high => VideoQuality.HighestQuality,
      CompressionQuality.ultra => VideoQuality.Res640x480Quality,
    };

    final originalFile = File(inputPath);
    final originalSize = await originalFile.length();

    final info = await VideoCompress.compressVideo(
      inputPath,
      qualityValue,
      deleteOrigin: deleteOriginal,
      includeAudio: includeAudio,
      frameRate: frameRate,
      startTime: startTimeMs,
      duration: durationMs,
    );

    if (info == null || info.path == null) {
      throw StateError('Video compression failed');
    }

    final compressedFile = File(info.path!);
    final compressedSize = await compressedFile.length();

    return CompressionResult(
      outputPath: info.path!,
      originalSizeBytes: originalSize,
      compressedSizeBytes: compressedSize,
      originalDuration:
          Duration(milliseconds: info.duration?.round() ?? 0),
      compressedDuration:
          Duration(milliseconds: info.duration?.round() ?? 0),
      width: info.width,
      height: info.height,
    );
  }

  Future<File?> generateThumbnail({
    required String videoPath,
    int quality = 80,
    int positionMs = 0,
  }) async {
    await initialize();
    return VideoCompress.getFileThumbnail(
      videoPath,
      quality: quality,
      position: positionMs,
    );
  }

  Future<MediaInfo?> getMediaInfo(String videoPath) async {
    await initialize();
    return VideoCompress.getMediaInfo(videoPath);
  }

  Stream<int> get progressStream => VideoCompress.compressProgress$;

  Future<void> cancelCompression() async {
    await VideoCompress.cancelCompression();
  }

  Future<void> dispose() async {
    VideoCompress.dispose();
  }
}
