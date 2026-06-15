class PlaceModel {
  final String id;
  final String name;
  final String type; // مطعم، متجر، مقهى...
  final double lat;
  final double lng;
  final String address;
  final double rating;
  final int reviewCount;
  final String? imageEmoji;
  final bool hasPromo;
  final String? promoText;

  PlaceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    required this.address,
    this.rating = 0,
    this.reviewCount = 0,
    this.imageEmoji,
    this.hasPromo = false,
    this.promoText,
  });
}
