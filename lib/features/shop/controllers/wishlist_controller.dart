import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistController extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  void toggle(ProductModel product) {
    final exists = _items.any((p) => p.id == product.id);
    if (exists) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(String productId) => _items.any((p) => p.id == productId);
}
