import '../models/rize_rewind_model.dart';
import 'mock_rize_posts.dart';

final mockRewind = RizeRewindModel(
  weekStart: DateTime.now().subtract(const Duration(days: 7)),
  topPosts: generateMockRizePosts().sublist(0, 3),
  totalLikes: 890,
  newFollowers: 45,
);
