class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final List<String> images;
  final String category;
  final String sellerId;
  final String sellerName;
  final double rating;
  final int reviewCount;
  final int stock;
  final bool hasDelivery;
  final double? deliveryFee;
  final bool codAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.images,
    required this.category,
    required this.sellerId,
    required this.sellerName,
    this.rating = 0,
    this.reviewCount = 0,
    this.stock = 1,
    this.hasDelivery = true,
    this.deliveryFee,
    this.codAvailable = true,
  });
}
