class RizeAnalyticsModel {
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final int profileViews;
  final int newFollowers;
  final List<int> dailyLikes; // آخر 7 أيام

  const RizeAnalyticsModel({
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.profileViews,
    required this.newFollowers,
    required this.dailyLikes,
  });
}
