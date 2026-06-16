import 'package:flutter/material.dart';

class LevelController extends ChangeNotifier {
  int _xp = 0, _level = 1, _xpToNext = 100;
  int get xp => _xp;
  int get level => _level;
  int get xpToNext => _xpToNext;

  void addXp(int amount) {
    _xp += amount;
    while (_xp >= _xpToNext) {
      _xp -= _xpToNext;
      _level++;
      _xpToNext = (_xpToNext * 1.5).ceil();
    }
    notifyListeners();
  }
}
