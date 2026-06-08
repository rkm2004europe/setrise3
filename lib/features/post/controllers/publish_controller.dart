import 'package:flutter/material.dart';

class CameraState {
  final bool isRecording;
  final bool frontCamera;
  final bool flashOn;

  const CameraState({
    this.isRecording = false,
    this.frontCamera = false,
    this.flashOn = false,
  });

  CameraState copyWith({
    bool? isRecording,
    bool? frontCamera,
    bool? flashOn,
  }) {
    return CameraState(
      isRecording: isRecording ?? this.isRecording,
      frontCamera: frontCamera ?? this.frontCamera,
      flashOn: flashOn ?? this.flashOn,
    );
  }
}

class CameraController extends ChangeNotifier {
  CameraState _state = const CameraState();

  CameraState get state => _state;

  void toggleCamera() {
    _state = _state.copyWith(frontCamera: !_state.frontCamera);
    notifyListeners();
  }

  void toggleFlash() {
    _state = _state.copyWith(flashOn: !_state.flashOn);
    notifyListeners();
  }

  void startRecording() {
    _state = _state.copyWith(isRecording: true);
    notifyListeners();
  }

  void stopRecording() {
    _state = _state.copyWith(isRecording: false);
    notifyListeners();
  }
}
