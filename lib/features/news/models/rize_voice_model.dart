class RizeVoiceModel {
  final String id;
  final String userId;
  final String userName;
  final String username;
  final String title;
  final String audioUrl;
  final Duration duration;
  final DateTime createdAt;

  const RizeVoiceModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.username,
    required this.title,
    required this.audioUrl,
    required this.duration,
    required this.createdAt,
  });
}
