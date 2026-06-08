import 'package:flutter/material.dart';

class RizeQuoteController extends ChangeNotifier {
  bool _isPublishing = false;
  bool get isPublishing => _isPublishing;

  Future<void> publishQuote() async {
    _isPublishing = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isPublishing = false;
    notifyListeners();
  }
}
