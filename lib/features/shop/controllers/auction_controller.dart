// lib/features/shop/controllers/auction_controller.dart
// Singleton + ChangeNotifier + منطق مزايدة صحيح

import 'package:flutter/material.dart';
import '../models/auction_model.dart';
import '../services/auction_service.dart';

class AuctionController extends ChangeNotifier {
  final AuctionService _service = AuctionService();

  List<AuctionModel> _auctions = [];
  bool _isLoading = false;
  String? _error;
  String? _currentBidderId;

  List<AuctionModel> get auctions => List.unmodifiable(_auctions);
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<AuctionModel> get activeAuctions => _auctions.where((a) => a.isActive).toList();

  Future<void> loadAuctions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _auctions = await _service.fetchAuctions();
    } catch (e) {
      _error = 'فشل تحميل المزادات: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> placeBid(AuctionModel auction, double amount) async {
    final bidderId = _currentBidderId ?? 'me';
    final success = await _service.placeBid(
      auctionId: auction.id, bidderId: bidderId, amount: amount);
    if (success) {
      final idx = _auctions.indexWhere((a) => a.id == auction.id);
      if (idx != -1) {
        _auctions[idx].currentBid = amount;
        _auctions[idx].highestBidderId = bidderId;
        if (!_auctions[idx].bidderIds.contains(bidderId)) {
          _auctions[idx].bidderIds.add(bidderId);
        }
      }
      notifyListeners();
    }
    return success;
  }

  void setCurrentBidder(String userId) {
    _currentBidderId = userId;
    notifyListeners();
  }
}
