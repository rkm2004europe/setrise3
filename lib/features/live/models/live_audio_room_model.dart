class LiveAudioRoomModel {
  final String id;
  final String hostId;
  final String hostName;
  final String hostAvatar;
  final String title;
  final List<SpeakerModel> speakers; // المتحدثون الحاليون
  final List<String> raisedHands; // مستخدمون يريدون التحدث
  final int listenerCount; // عدد المستمعين
  final bool isLive;
  final String? category;

  LiveAudioRoomModel({
    required this.id,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    required this.title,
    this.speakers = const [],
    this.raisedHands = const [],
    this.listenerCount = 0,
    this.isLive = true,
    this.category,
  });
}
