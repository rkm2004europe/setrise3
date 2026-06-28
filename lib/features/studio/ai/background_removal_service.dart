library;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';

class SegmentationMask {
  final Uint8List bytes;
  final int width;
  final int height;

  const SegmentationMask({
    required this.bytes,
    required this.width,
    required this.height,
  });

  bool isForeground(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return false;
    return bytes[y * width + x] > 128;
  }
}

class BackgroundRemovalService {
  BackgroundRemovalService({SelfieSegmenter? segmenter})
      : _segmenter = segmenter ?? SelfieSegmenter(
          mode: SegmenterMode.stream,
          enableRawSizeMask: true,
          enableRawSizeMaskConfidence: true,
        );

  final SelfieSegmenter _segmenter;
  bool _isInitialised = false;

  Future<void> initialize() async {
    _isInitialised = true;
  }

  Future<SegmentationMask?> segmentFromBytes(
    Uint8List bytes, {
    required int width,
    required int height,
  }) async {
    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: ui.Size(width.toDouble(), height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: width,
      ),
    );
    final mask = await _segmenter.processImage(inputImage);
    final raw = mask.rawSizeMask;
    if (raw == null) return null;
    return SegmentationMask(
      bytes: raw.bytes,
      width: raw.size.width.toInt(),
      height: raw.size.height.toInt(),
    );
  }

  Future<void> dispose() async {
    await _segmenter.close();
  }
}
