import '../models/challenge_model.dart';
import '../data/mock_challenges.dart';

class ChallengeService {
  Future<List<ChallengeModel>> fetchChallenges() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockChallenges.where((c) => c.isActive).toList();
  }
}
