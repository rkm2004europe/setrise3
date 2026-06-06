// lib/features/shop/screens/flash_deals_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/widgets/product_grid_card.dart';

class FlashDealsScreen extends StatelessWidget {
  const FlashDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deals = ProductModel.getFlashDeals();
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Flash Deals',
          style: TextStyle(color: CupertinoColors.white))),
      child: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.65,
            crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: deals.length,
          itemBuilder: (_, i) => ProductGridCard(product: deals[i]))),
    );
  }
}

