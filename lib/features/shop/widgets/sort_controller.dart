import 'package:flutter/material.dart';

class SortController extends ChangeNotifier {
  String _current = 'latest';
  String get current => _current;

  void setSort(String sort) { _current = sort; notifyListeners(); }
}
