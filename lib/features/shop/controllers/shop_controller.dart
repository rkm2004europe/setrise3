// lib/features/shop/controllers/shop_controller.dart
// Singleton + ChangeNotifier + معالجة أخطاء

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/shop_api_service.dart';

class ShopController extends ChangeNotifier {
  static final ShopController _instance = ShopController._();
  factory ShopController() => _instance;
  ShopController._();

  final ShopApiService _service = ShopApiService();

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _products = await _service.fetchProducts();
    } catch (e) {
      _error = 'فشل تحميل المنتجات. تحقق من اتصالك بالإنترنت.';
      debugPrint('ShopController.loadProducts error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => loadProducts();

  List<ProductModel> byCategory(String category) {
    if (category == 'الكل' || category.isEmpty) return _products;
    return _products.where((p) => p.category == category).toList();
  }

  List<ProductModel> search(String query) {
    if (query.isEmpty) return _products;
    final q = query.toLowerCase();
    return _products.where((p) =>
      p.name.toLowerCase().contains(q) ||
      p.description.toLowerCase().contains(q) ||
      p.category.toLowerCase().contains(q)
    ).toList();
  }
}
