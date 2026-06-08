import 'package:flutter/material.dart';
import '../services/rize_voice_service.dart';

class RizeVoiceController extends ChangeNotifier {
  final RizeVoiceService _service = RizeVoiceService();
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> play(String url) async {
    _isPlaying = true;
    notifyListeners();
    await _service.playAudio(url);
    _isPlaying = false;
    notifyListeners();
  }
}
