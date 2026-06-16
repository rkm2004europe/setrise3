import '../models/giveaway_model.dart';
import '../data/mock_giveaways.dart';

class GiveawayService {
  Future<List<GiveawayModel>> fetchGiveaways() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockGiveaways;
  }
}
