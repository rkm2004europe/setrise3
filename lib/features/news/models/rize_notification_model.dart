enum RizeNotificationType { like, reply, repost, follow, mention }

class RizeNotificationModel {
  final String id;
  final RizeNotificationType type;
  final String actorUserId;
  final String actorUserName;
  final String? postId;
  final String? preview;
  final DateTime createdAt;
  bool isRead;

  RizeNotificationModel({
    required this.id,
    required this.type,
    required this.actorUserId,
    required this.actorUserName,
    this.postId,
    this.preview,
    required this.createdAt,
    this.isRead = false,
  });
}
