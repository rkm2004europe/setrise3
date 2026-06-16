import 'package:flutter/material.dart';
import '../models/battle_model.dart';

class BattleController extends ChangeNotifier {
  LiveBattleModel? _currentBattle;

  LiveBattleModel? get currentBattle => _currentBattle;

  void startBattle(LiveBattleModel battle) { _currentBattle = battle; notifyListeners(); }
  void addScore(String hostId, int points) {
    if (_currentBattle == null) return;
    if (_currentBattle!.host1Id == hostId) _currentBattle!.host1Score += points;
    if (_currentBattle!.host2Id == hostId) _currentBattle!.host2Score += points;
    notifyListeners();
  }
}
