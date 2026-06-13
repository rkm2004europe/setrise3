import 'package:flutter/material.dart';
import '../models/auction_model.dart';
import '../services/auction_service.dart';

class AuctionController extends ChangeNotifier {
  final AuctionService _service = AuctionService();
  List<AuctionModel> _auctions = [];

  List<AuctionModel> get auctions => _auctions;

  Future<void> loadAuctions() async {
    _auctions = await _service.fetchAuctions();
    notifyListeners();
  }

  void placeBid(AuctionModel auction, double amount) {
    auction.currentBid += amount;
    notifyListeners();
  }
}
