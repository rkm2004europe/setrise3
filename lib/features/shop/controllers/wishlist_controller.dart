// lib/features/shop/controllers/wishlist_controller.dart
//
// متحكم قائمة الأمنيات — Singleton + ChangeNotifier
//
// الإصلاحات:
//   - تحويل إلى Singleton حتى يبقى محفوظاً عبر جلسة التطبيق
//   - إضافة clear() و size
//   - إبقاء الـ API الأصلي (toggle, isInWishlist, items)

import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistController extends ChangeNotifier {
  static final WishlistController _instance = WishlistController._();
  factory WishlistController() => _instance;
  WishlistController._();

  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);
  int get size => _items.length;
  bool get isEmpty => _items.isEmpty;

  void toggle(ProductModel product) {
    final exists = _items.any((p) => p.id == product.id);
    if (exists) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void add(ProductModel product) {
    if (!_items.any((p) => p.id == product.id)) {
      _items.add(product);
      notifyListeners();
    }
  }

  void remove(String productId) {
    _items.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  bool isInWishlist(String productId) =>
      _items.any((p) => p.id == productId);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
