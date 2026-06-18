import 'package:flutter/material.dart';

class ViewerProgressController extends ChangeNotifier {
  int _xp = 0;
  int _level = 1;
  int _xpToNextLevel = 100;
  List<String> _badges = [];

  int get xp => _xp;
  int get level => _level;
  int get xpToNextLevel => _xpToNextLevel;
  List<String> get badges => _badges;

  void addXp(int amount) {
    _xp += amount;
    while (_xp >= _xpToNextLevel) {
      _xp -= _xpToNextLevel;
      _level++;
      _xpToNextLevel = (_xpToNextLevel * 1.5).ceil();
      _checkBadges();
    }
    notifyListeners();
  }

  void _checkBadges() {
    if (_level >= 5 && !_badges.contains('مراسل')) _badges.add('مراسل');
    if (_level >= 10 && !_badges.contains('مشجع')) _badges.add('مشجع');
    if (_level >= 20 && !_badges.contains('أسطورة')) _badges.add('أسطورة');
  }
}
