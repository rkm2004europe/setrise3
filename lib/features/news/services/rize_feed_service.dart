import '../models/rize_post_model.dart';
import '../data/mock_rize_posts.dart';

class RizeFeedService {
  Future<List<RizePostModel>> fetchFeed() async {
    await Future.delayed(const Duration(seconds: 1));
    return generateMockRizePosts();
  }

  Future<List<RizePostModel>> fetchTrending() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return generateMockRizePosts();
  }

  Future<List<RizePostModel>> fetchFollowing() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return generateMockRizePosts().sublist(0, 5);
  }
}
