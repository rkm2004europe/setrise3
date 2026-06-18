import 'package:flutter/material.dart';
import '../models/giveaway_model.dart';
import '../services/giveaway_service.dart';

class GiveawayController extends ChangeNotifier {
  final GiveawayService _service = GiveawayService();
  List<GiveawayModel> _giveaways = [];
  List<GiveawayModel> get giveaways => _giveaways;

  Future<void> load() async {
    _giveaways = await _service.fetchGiveaways();
    notifyListeners();
  }

  void pickWinner(String giveawayId) {
    final giveaway = _giveaways.firstWhere((g) => g.id == giveawayId);
    if (giveaway.participants.isNotEmpty) {
      giveaway.participants.shuffle();
      // إعلان فائز
    }
    notifyListeners();
  }
}
