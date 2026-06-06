// lib/features/shop/screens/category_products_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/widgets/product_grid_card.dart';
import 'package:setrise/features/shop/services/cart_service.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;
  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late List<ProductModel> _products;
  final _cart = CartService();

  @override
  void initState() {
    super.initState();
    _products = ProductModel.getFeaturedProducts()
        .where((p) => p.category == widget.category)
        .toList();
    if (_products.isEmpty) _products = ProductModel.getFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text(widget.category,
          style: const TextStyle(color: Colors.white)),
        trailing: const Icon(CupertinoIcons.search, color: Colors.white)),
      child: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.65,
            crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _products.length,
          itemBuilder: (_, i) => ProductGridCard(
            product: _products[i],
            onTap: () {
              _cart.addItem(CartItem(
                id: _products[i].id,
                imageUrl: _products[i].images.first,
                brand: _products[i].brand,
                name: _products[i].name,
                price: _products[i].price));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Added to cart'),
                backgroundColor: ShopColors.accent,
                duration: Duration(seconds: 1)));
            })),
      ),
    );
  }
}

