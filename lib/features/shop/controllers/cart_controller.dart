import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartController extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  void addItem(ProductModel product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItemModel(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
}
