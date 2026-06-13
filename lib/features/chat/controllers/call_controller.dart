import 'package:flutter/material.dart';
import '../services/call_service.dart';

class CallController extends ChangeNotifier {
  final CallService _service = CallService();
  bool _inCall = false;
  bool get inCall => _inCall;

  Future<void> startCall(String userId, bool isVideo) async {
    _inCall = true;
    notifyListeners();
    await _service.startCall(userId, isVideo);
    _inCall = false;
    notifyListeners();
  }
}
