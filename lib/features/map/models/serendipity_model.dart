class SerendipityModel {
  final String userId;
  final String userName;
  final String avatar;
  final double compatibilityScore;
  final List<String> sharedInterests;

  SerendipityModel({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.compatibilityScore,
    required this.sharedInterests,
  });
}
