class LiveAuctionModel {
  final String id;
  final String productId;
  final String streamUrl;
  final List<String> viewers;
  bool isActive;

  LiveAuctionModel({
    required this.id,
    required this.productId,
    required this.streamUrl,
    required this.viewers,
    this.isActive = true,
  });
}
