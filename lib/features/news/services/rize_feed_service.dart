import '../models/rize_post_model.dart';
import '../data/mock_rize_posts.dart';

class RizeFeedService {
  Future<List<RizePostModel>> fetchFeed() async {
    // محاكاة استدعاء API
    await Future.delayed(const Duration(seconds: 1));
    return generateMockRizePosts();
  }
}
