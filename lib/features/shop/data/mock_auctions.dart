import '../models/auction_model.dart';

final List<AuctionModel> mockAuctions = [
  AuctionModel(
    id: 'a1', productName: 'ساعة ذكية', image: '⌚', startingPrice: 200, currentBid: 350, highestBidderId: 'u1', endTime: DateTime.now().add(const Duration(hours: 2)), bidderIds: ['u1', 'u2', 'u3'],
  ),
  AuctionModel(
    id: 'a2', productName: 'سماعات احترافية', image: '🎧', startingPrice: 100, currentBid: 180, highestBidderId: 'u5', endTime: DateTime.now().add(const Duration(minutes: 45)), bidderIds: ['u5', 'u6'],
  ),
];
