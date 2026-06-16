class SpeakerModel {
  final String userId;
  final String userName;
  final String avatar;
  bool isMuted;
  bool isSpeaking;

  SpeakerModel({
    required this.userId,
    required this.userName,
    required this.avatar,
    this.isMuted = false,
    this.isSpeaking = false,
  });
}
