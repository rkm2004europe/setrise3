class DateStoryModel {
  final String id;
  final String userId;
  final String userName;
  final String avatar;
  final List<String> mediaUrls;
  final DateTime createdAt;
  final bool isLive;

  DateStoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.mediaUrls,
    required this.createdAt,
    this.isLive = false,
  });
}
