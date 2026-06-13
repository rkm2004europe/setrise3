class AuctionModel {
  final String id;
  final String productName;
  final String image;
  final double startingPrice;
  double currentBid;
  String? highestBidderId;
  final DateTime endTime;
  final List<String> bidderIds;

  AuctionModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.startingPrice,
    required this.currentBid,
    this.highestBidderId,
    required this.endTime,
    this.bidderIds = const [],
  });

  bool get isActive => DateTime.now().isBefore(endTime);
  Duration get timeLeft => endTime.difference(DateTime.now());
}
