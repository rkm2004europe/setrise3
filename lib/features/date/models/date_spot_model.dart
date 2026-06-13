class DateSpotModel {
  final String id;
  final String name;
  final String type; // مقهى، مطعم، حديقة
  final String address;
  final double rating;
  final String imageEmoji;
  final int checkins;
  final double distance; // كم

  DateSpotModel({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.rating,
    required this.imageEmoji,
    required this.checkins,
    required this.distance,
  });
}
