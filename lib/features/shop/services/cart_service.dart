// lib/features/shop/services/cart_service.dart
// Singleton + ChangeNotifier + ValueNotifier

import 'package:flutter/foundation.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._();
  factory CartService() => _instance;
  CartService._();

  final List<CartItemModel> _items = [];

  List<CartItemModel> get itemsList => List.unmodifiable(_items);
  double get subtotal => _items.fold(0.0, (sum, i) => sum + i.product.price * i.quantity);
  int get totalItems => _items.fold(0, (sum, i) => sum + i.quantity);

  final ValueNotifier<List<CartItemModel>> items = ValueNotifier(const []);

  void addItem(ProductModel product, {int quantity = 1}) {
    final idx = _items.indexWhere((i) => i.product.id == product.id);
    if (idx != -1) {
      _items[idx].quantity += quantity;
    } else {
      _items.add(CartItemModel(product: product, quantity: quantity));
    }
    _notify();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    _notify();
  }

  void increment(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx != -1) { _items[idx].quantity++; _notify(); }
  }

  void decrement(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx == -1) return;
    if (_items[idx].quantity <= 1) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity--;
    }
    _notify();
  }

  void clear() { _items.clear(); _notify(); }

  bool isInCart(String productId) => _items.any((i) => i.product.id == productId);

  void _notify() {
    items.value = List.from(_items);
    notifyListeners();
  }
}
