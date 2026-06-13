import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/shop_api_service.dart';

class ShopController extends ChangeNotifier {
  final ShopApiService _service = ShopApiService();
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    _products = await _service.fetchProducts();
    _isLoading = false;
    notifyListeners();
  }
}
