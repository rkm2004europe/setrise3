// lib/features/shop/services/cart_service.dart

import 'package:flutter/foundation.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._();
  factory CartService() => _instance;
  CartService._();

  final List<CartItem> _items = [];

  List<CartItem> get itemsList => List.unmodifiable(_items);
  double get subtotal => _items.fold(0, (sum, i) => sum + i.price * i.quantity);
  int get totalItems => _items.fold(0, (sum, i) => sum + i.quantity);

  final ValueNotifier<List<CartItem>> items = ValueNotifier([]);

  void addItem(CartItem item) {
    final idx = _items.indexWhere((i) => i.id == item.id);
    if (idx != -1) {
      _items[idx].quantity++;
    } else {
      _items.add(item);
    }
    items.value = List.from(_items);
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.removeWhere((i) => i.id == id);
    items.value = List.from(_items);
    notifyListeners();
  }

  void updateQuantity(String id, int newQty) {
    final idx = _items.indexWhere((i) => i.id == id);
    if (idx != -1) {
      if (newQty <= 0) {
        _items.removeAt(idx);
      } else {
        _items[idx].quantity = newQty;
      }
      items.value = List.from(_items);
      notifyListeners();
    }
  }
}

