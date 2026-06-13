class MarketplaceListingModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String sellerId;
  final String sellerName;
  final String location;
  final DateTime postedAt;
  final bool isBoosted;

  MarketplaceListingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.sellerId,
    required this.sellerName,
    required this.location,
    required this.postedAt,
    this.isBoosted = false,
  });
}
