import 'package:flutter/material.dart';
import '../models/product_model.dart';

class SellerController extends ChangeNotifier {
  List<ProductModel> _myProducts = [];

  List<ProductModel> get myProducts => _myProducts;

  void addProduct(ProductModel product) {
    _myProducts.add(product);
    notifyListeners();
  }

  void removeProduct(String productId) {
    _myProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
