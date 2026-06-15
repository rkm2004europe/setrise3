import 'package:flutter/material.dart';
import '../models/xp_model.dart';
import '../services/xp_service.dart';

class XpController extends ChangeNotifier {
  final XpService _service = XpService();
  late XpModel _xp = _service.getXp();
  XpModel get xp => _xp;

  void addXp(int amount) {
    _xp = XpModel(currentXp: _xp.currentXp + amount, level: _xp.level, xpToNextLevel: _xp.xpToNextLevel, badges: _xp.badges);
    notifyListeners();
  }
}
