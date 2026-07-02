// lib/features/shop/services/auction_service.dart

import '../models/auction_model.dart';
import '../data/mock_auctions.dart';

class AuctionService {
  Future<List<AuctionModel>> fetchAuctions() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<AuctionModel>.from(mockAuctions);
  }

  Future<AuctionModel?> fetchAuctionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return mockAuctions.firstWhere((a) => a.id == id);
    } catch (_) { return null; }
  }

  Future<bool> placeBid({
    required String auctionId,
    required String bidderId,
    required double amount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final auction = mockAuctions.firstWhere((a) => a.id == auctionId);
      if (!auction.isActive) return false;
      if (amount <= auction.currentBid) return false;
      auction.currentBid = amount;
      auction.highestBidderId = bidderId;
      if (!auction.bidderIds.contains(bidderId)) {
        auction.bidderIds.add(bidderId);
      }
      return true;
    } catch (_) { return false; }
  }

  Future<List<AuctionModel>> fetchActiveAuctions() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockAuctions.where((a) => a.isActive).toList();
  }
}
