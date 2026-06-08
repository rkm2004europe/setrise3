import '../models/rize_community_model.dart';
import '../data/mock_rize_communities.dart';

class RizeCommunityService {
  Future<List<RizeCommunityModel>> fetchCommunities() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockCommunities;
  }
}
