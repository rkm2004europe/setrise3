library;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class DetectedFace {
  final ui.Rect bounds;
  final List<ui.Offset> landmarks;
  final double? smilingProbability;
  final double? leftEyeOpenProbability;
  final double? rightEyeOpenProbability;
  final double? headEulerAngleY;

  const DetectedFace({
    required this.bounds,
    required this.landmarks,
    this.smilingProbability,
    this.leftEyeOpenProbability,
    this.rightEyeOpenProbability,
    this.headEulerAngleY,
  });
}

class FaceDetectionService {
  FaceDetectionService({FaceDetectorOptions? options})
      : _detector = FaceDetector(
          options: options ??
              const FaceDetectorOptions(
                enableContours: true,
                enableLandmarks: true,
                enableClassification: true,
                enableTracking: true,
                performanceMode: FaceDetectorMode.fast,
                minFaceSize: 0.15,
              ),
        );

  final FaceDetector _detector;
  bool _initialised = false;

  Future<void> initialize() async {
    _initialised = true;
  }

  Future<List<DetectedFace>> detectFromBytes(
    Uint8List bytes, {
    required int sourceWidth,
    required int sourceHeight,
  }) async {
    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: ui.Size(sourceWidth.toDouble(), sourceHeight.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: sourceWidth,
      ),
    );

    final faces = await _detector.processImage(inputImage);
    return faces.map((f) {
      return DetectedFace(
        bounds: ui.Rect.fromLTWH(
          f.boundingBox.left / sourceWidth,
          f.boundingBox.top / sourceHeight,
          f.boundingBox.width / sourceWidth,
          f.boundingBox.height / sourceHeight,
        ),
        landmarks: f.landmarks.values
            .map((p) => p.position)
            .map((pos) =>
                ui.Offset(pos.dx / sourceWidth, pos.dy / sourceHeight))
            .toList(),
        smilingProbability: f.smilingProbability,
        leftEyeOpenProbability: f.leftEyeOpenProbability,
        rightEyeOpenProbability: f.rightEyeOpenProbability,
        headEulerAngleY: f.headEulerAngleY,
      );
    }).toList();
  }

  final StreamController<List<DetectedFace>> _streamController =
      StreamController<List<DetectedFace>>.broadcast();
  Stream<List<DetectedFace>> get stream => _streamController.stream;

  bool get isInitialised => _initialised;

  Future<void> dispose() async {
    await _detector.close();
    await _streamController.close();
  }
}
