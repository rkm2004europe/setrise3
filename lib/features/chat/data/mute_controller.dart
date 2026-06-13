import 'package:flutter/material.dart';

class MuteController extends ChangeNotifier {
  final Map<String, bool> _muted = {};

  bool isMuted(String convId) => _muted[convId] ?? false;

  void toggle(String convId) {
    _muted[convId] = !(_muted[convId] ?? false);
    notifyListeners();
  }
}
