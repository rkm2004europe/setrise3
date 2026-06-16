enum VoiceRoomRole { host, moderator, speaker, listener }

class VoiceRoomParticipant {
  final String userId;
  final String userName;
  final String avatar;
  VoiceRoomRole role;
  bool isMuted;
  bool hasRaisedHand;

  VoiceRoomParticipant({
    required this.userId,
    required this.userName,
    required this.avatar,
    this.role = VoiceRoomRole.listener,
    this.isMuted = true,
    this.hasRaisedHand = false,
  });
}

class VoiceRoomModel {
  final String id;
  final String title;
  final String hostId;
  final String hostName;
  final String hostAvatar;
  final String? topicEmoji;
  final List<String> tags;
  final int listenerCount;
  final int speakerCount;
  final bool isLive;
  final DateTime? scheduledTime;

  VoiceRoomModel({
    required this.id,
    required this.title,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    this.topicEmoji,
    this.tags = const [],
    this.listenerCount = 0,
    this.speakerCount = 0,
    this.isLive = true,
    this.scheduledTime,
  });
}
