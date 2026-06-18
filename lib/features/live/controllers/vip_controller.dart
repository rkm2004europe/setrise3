import 'package:flutter/material.dart';
import '../models/vip_system_model.dart';

class VipController extends ChangeNotifier {
  int _totalCoinsSpent = 0;
  VipLevel _currentLevel = vipLevels.first;

  VipLevel get currentLevel => _currentLevel;

  void addCoinsSpent(int amount) {
    _totalCoinsSpent += amount;
    _updateLevel();
  }

  void _updateLevel() {
    for (final level in vipLevels.reversed) {
      if (_totalCoinsSpent >= level.requiredCoins) {
        _currentLevel = level;
        break;
      }
    }
    notifyListeners();
  }
}
