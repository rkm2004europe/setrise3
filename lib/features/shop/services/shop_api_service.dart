// lib/features/shop/services/shop_api_service.dart

import '../models/product_model.dart';
import '../data/mock_products.dart';

class ShopApiService {
  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockProducts;
  }
}
