class RizeReplyModel {
  final String id;
  final String userId;
  final String userName;
  final String username;
  final String text;
  final DateTime createdAt;
  int likes;
  bool isLiked;
  List<RizeReplyModel> replies;

  RizeReplyModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.username,
    required this.text,
    DateTime? createdAt,
    this.likes = 0,
    this.isLiked = false,
    this.replies = const [],
  }) : createdAt = createdAt ?? DateTime.now();
}
