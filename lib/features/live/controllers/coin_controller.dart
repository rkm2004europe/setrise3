import 'package:flutter/material.dart';

class CoinController extends ChangeNotifier {
  int _balance = mockUserCoins;
  int get balance => _balance;

  void addCoins(int amount) { _balance += amount; notifyListeners(); }
  void spendCoins(int amount) { _balance -= amount; notifyListeners(); }
}
