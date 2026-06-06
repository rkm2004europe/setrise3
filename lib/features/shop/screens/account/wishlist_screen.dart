Enter// lib/features/shop/screens/account/wishlist_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/widgets/product_grid_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<ProductModel> _favorites = ProductModel.getFeaturedProducts()
      .where((p) => p.isFavorite)
      .toList();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text('Wishlist', style: TextStyle(color: Colors.white))),
      child: SafeArea(
        child: _favorites.isEmpty
          ? const Center(child: Text('Your wishlist is empty',
              style: TextStyle(color: ShopColors.grey)))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.65,
                crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: _favorites.length,
              itemBuilder: (_, i) => ProductGridCard(
                product: _favorites[i],
                onTap: () => setState(() =>
                  _favorites[i] = _favorites[i].copyWith(
                    isFavorite: !_favorites[i].isFavorite)))),
      ),
    );
  }
}
