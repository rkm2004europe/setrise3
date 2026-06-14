class ServiceModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category; // برمجة، تصميم، كتابة، ترجمة...
  final String providerId;
  final String providerName;
  final String providerAvatar;
  final double rating;
  final int reviewCount;
  final int deliveryDays;
  final bool isFeatured;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.providerId,
    required this.providerName,
    required this.providerAvatar,
    this.rating = 0,
    this.reviewCount = 0,
    this.deliveryDays = 3,
    this.isFeatured = false,
  });
}
