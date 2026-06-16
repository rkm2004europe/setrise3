import 'package:flutter/material.dart';
import '../models/gift_model.dart';

class GiftController extends ChangeNotifier {
  int _balance = mockUserCoins;
  int get balance => _balance;

  void sendGift(GiftModel gift) {
    _balance -= gift.coinValue;
    notifyListeners();
  }
}
