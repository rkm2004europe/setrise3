import 'package:flutter/material.dart';

class RizeSearchController extends ChangeNotifier {
  String _query = '';
  String get query => _query;

  void search(String q) {
    _query = q;
    notifyListeners();
  }
}
