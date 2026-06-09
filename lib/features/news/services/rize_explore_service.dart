import '../models/rize_explore_model.dart';
import '../data/mock_rize_explore.dart';

class RizeExploreService {
  Future<List<RizeExploreModel>> fetchExplore() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockExplore;
  }
}
