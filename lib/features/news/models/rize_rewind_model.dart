Enterimport 'rize_post_model.dart';

class RizeRewindModel {
  final DateTime weekStart;
  final List<RizePostModel> topPosts;
  final int totalLikes;
  final int newFollowers;

  const RizeRewindModel({
    required this.weekStart,
    required this.topPosts,
    required this.totalLikes,
    required this.newFollowers,
  });
}
