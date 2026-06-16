import '../models/battle_model.dart';
import '../data/mock_battles.dart';

class BattleService {
  Future<List<LiveBattleModel>> fetchBattles() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockBattles;
  }
}
