// lib/features/shop/screens/shop_home_screen.dart
// الشاشة الرئيسية للمتجر — أقسام + شبكة منتجات + روابط سريعة

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_categories.dart';
import '../data/mock_products.dart';
import '../widgets/product_card.dart';
import '../controllers/shop_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../services/cart_service.dart';
import 'auction_list_screen.dart';
import 'marketplace_screen.dart';
import 'food_delivery_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'search_shop_screen.dart';
import 'order_history_screen.dart';
import 'category_screen.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  final _shopCtrl = ShopController();
  final _wishlist = WishlistController();
  final _cart = CartService();

  @override
  void initState() {
    super.initState();
    _shopCtrl.loadProducts();
    _wishlist.addListener(_onChanged);
    _cart.addListener(_onChanged);
  }

  @override
  void dispose() {
    _wishlist.removeListener(_onChanged);
    _cart.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // شريط علوي
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('SetRise Shop', style: TextStyle(
                      color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900,
                    )),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.search, color: ShopColors.text),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SearchShopScreen())),
                    ),
                    Stack(children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border, color: ShopColors.text),
                        onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const WishlistScreen())),
                      ),
                      if (_wishlist.size > 0)
                        Positioned(
                          right: 6, top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: ShopColors.red, shape: BoxShape.circle),
                            child: Text('${_wishlist.size}', style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ]),
                    Stack(children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, color: ShopColors.text),
                        onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const CartScreen())),
                      ),
                      if (_cart.totalItems > 0)
                        Positioned(
                          right: 6, top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: ShopColors.accent, shape: BoxShape.circle),
                            child: Text('${_cart.totalItems}', style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ]),
                  ],
                ),
              ),

              // إجراءات سريعة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _quickAction(context, Icons.history, 'طلباتي', ShopColors.accent, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen()));
                    }),
                    const SizedBox(width: 10),
                    _quickAction(context, Icons.gavel, 'المزادات', ShopColors.gold, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionListScreen()));
                    }),
                    const SizedBox(width: 10),
                    _quickAction(context, Icons.storefront, 'السوق المفتوح', ShopColors.green, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // الأقسام
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    return GestureDetector(
                      onTap: () {
                        final name = cat['name']!;
                        if (name == 'مزادات') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionListScreen()));
                        } else if (name == 'سوق مفتوح') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
                        } else if (name == 'طعام' || name == 'توصيل') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodDeliveryScreen()));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(categoryName: name)));
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60, height: 60,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                            child: Center(child: Text(cat['icon']!, style: const TextStyle(fontSize: 28))),
                          ),
                          const SizedBox(height: 6),
                          Text(cat['name']!, style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // عنوان المنتجات المميزة
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('منتجات مميزة', style: TextStyle(
                  color: ShopColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 10),

              // شبكة المنتجات
              if (_shopCtrl.isLoading)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator(color: ShopColors.accent)),
                )
              else if (_shopCtrl.error != null)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text(_shopCtrl.error!,
                    style: const TextStyle(color: ShopColors.red), textAlign: TextAlign.center)),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75),
                  itemCount: _shopCtrl.products.isNotEmpty ? _shopCtrl.products.length : mockProducts.length,
                  itemBuilder: (_, i) => ProductCard(
                    product: _shopCtrl.products.isNotEmpty ? _shopCtrl.products[i] : mockProducts[i],
                  ),
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(
                color: ShopColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
