class MapStoryModel {
  final String id;
  final String userId;
  final String userName;
  final String avatar;
  final String mediaUrl;
  final String locationName;
  final double lat;
  final double lng;
  final DateTime createdAt;
  final bool isLive;
  final int viewsCount;

  MapStoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.mediaUrl,
    required this.locationName,
    required this.lat,
    required this.lng,
    required this.createdAt,
    this.isLive = false,
    this.viewsCount = 0,
  });

  bool get isExpired => DateTime.now().difference(createdAt).inHours >= 24;
}
