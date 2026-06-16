import 'package:flutter/material.dart';

class MonetizationController extends ChangeNotifier {
  double _earnings = 0;
  double get earnings => _earnings;

  void addEarnings(double amount) { _earnings += amount; notifyListeners(); }
}
