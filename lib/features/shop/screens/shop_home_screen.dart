// lib/features/shop/screens/shop_home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/services/cart_service.dart';
import 'package:setrise/features/shop/screens/cart/cart_screen.dart';
import 'package:setrise/features/shop/screens/widgets/banner_section.dart';
import 'package:setrise/features/shop/screens/widgets/categories_section.dart';
import 'package:setrise/features/shop/screens/widgets/live_auctions_section.dart';
import 'package:setrise/features/shop/screens/widgets/stores_section.dart';
import 'package:setrise/features/shop/screens/widgets/products_grid_section.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartService();
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        border: const Border(bottom: BorderSide.none),
        middle: const Text('Shop', style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        trailing: ValueListenableBuilder<List<CartItem>>(
          valueListenable: cart.items,
          builder: (_, items, __) => CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.push(context,
              CupertinoPageRoute(builder: (_) => const CartScreen())),
            child: Stack(children: [
              const Icon(CupertinoIcons.cart, color: Colors.white, size: 26),
              if (cart.totalItems > 0)
                Positioned(top: 0, right: 0,
                  child: Container(
                    width: 14, height: 14,
                    decoration: const BoxDecoration(
                      color: ShopColors.red, shape: BoxShape.circle),
                    child: Center(child: Text('${cart.totalItems}',
                      style: const TextStyle(color: Colors.white,
                        fontSize: 9, fontWeight: FontWeight.w900))))),
            ]))),
      ),
      child: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(child: CategoriesSection()),
          const SliverToBoxAdapter(child: BannerSection()),
          const SliverToBoxAdapter(child: LiveAuctionsSection()),
          const SliverToBoxAdapter(child: StoresSection()),
          const SliverToBoxAdapter(child: ProductsGridSection()),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ]),
      ),
    );
  }
}

