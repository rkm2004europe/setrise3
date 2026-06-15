enum HotspotCategory { music, food, sports, shopping, general }

class HotspotModel {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final double radius; // meters
  final HotspotCategory category;
  final int activityCount;
  final bool isTrending;

  HotspotModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.radius,
    required this.category,
    required this.activityCount,
    this.isTrending = false,
  });
}
