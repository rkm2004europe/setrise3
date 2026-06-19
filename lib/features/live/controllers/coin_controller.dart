import 'package:flutter/material.dart';
import '../data/mock_coins.dart';

class CoinController extends ChangeNotifier {
  int _balance = mockUserCoins;
  int get balance => _balance;

  void addCoins(int amount) { _balance += amount; notifyListeners(); }
  bool spendCoins(int amount) {
    if (_balance >= amount) { _balance -= amount; notifyListeners(); return true; }
    return false;
  }
}
