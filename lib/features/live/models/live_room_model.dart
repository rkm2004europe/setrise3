class LiveRoomModel {
  final String id;
  final String hostId;
  final String hostName;
  final String hostAvatar;
  final String title;
  final String? category;
  final int viewerCount;
  final List<String> tags;
  final bool isLive;
  final String? thumbnailEmoji;
  final double? lat;
  final double? lng;

  LiveRoomModel({
    required this.id,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    required this.title,
    this.category,
    this.viewerCount = 0,
    this.tags = const [],
    this.isLive = true,
    this.thumbnailEmoji,
    this.lat,
    this.lng,
  });
}
