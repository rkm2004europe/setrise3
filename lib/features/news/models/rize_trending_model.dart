class RizeTrendingModel {
  final String title;
  final int postsCount;
  final String? hashtag;

  const RizeTrendingModel({
    required this.title,
    required this.postsCount,
    this.hashtag,
  });
}
