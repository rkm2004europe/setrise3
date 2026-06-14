import 'package:flutter/material.dart';

class FilterController extends ChangeNotifier {
  String _category = 'الكل';
  double _minPrice = 0;
  double _maxPrice = 10000;
  String _sortBy = 'latest';

  String get category => _category;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  String get sortBy => _sortBy;

  void setCategory(String c) { _category = c; notifyListeners(); }
  void setPriceRange(double min, double max) { _minPrice = min; _maxPrice = max; notifyListeners(); }
  void setSortBy(String s) { _sortBy = s; notifyListeners(); }
}
