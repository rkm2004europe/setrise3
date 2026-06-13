import 'package:flutter/material.dart';
import '../services/media_service.dart';

class MediaController extends ChangeNotifier {
  final MediaService _service = MediaService();
  double _progress = 0;
  double get progress => _progress;

  Future<String?> upload(String path) async {
    _progress = 0;
    notifyListeners();
    final url = await _service.uploadMedia(path);
    _progress = 1;
    notifyListeners();
    return url;
  }
}
