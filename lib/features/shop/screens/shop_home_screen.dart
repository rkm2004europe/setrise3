import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_categories.dart';
import '../data/mock_products.dart';
import '../widgets/product_card.dart';
import 'auction_list_screen.dart';
import 'marketplace_screen.dart';
import 'food_delivery_screen.dart';
import 'cart_screen.dart';
import 'search_shop_screen.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
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
                    const Text('Shop', style: TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.search, color: ShopColors.text), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchShopScreen()))),
                    IconButton(icon: const Icon(Icons.shopping_cart, color: ShopColors.text), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
                  ],
                ),
              ),
              // الأقسام
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () {
                      if (categories[i]['name'] == 'مزادات') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AuctionListScreen()));
                      } else if (categories[i]['name'] == 'سوق مفتوح') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
                      } else if (categories[i]['name'] == 'طعام' || categories[i]['name'] == 'توصيل') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodDeliveryScreen()));
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60, height: 60, margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                          child: Center(child: Text(categories[i]['icon']!, style: const TextStyle(fontSize: 28))),
                        ),
                        const SizedBox(height: 6),
                        Text(categories[i]['name']!, style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // المنتجات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text('منتجات مميزة', style: TextStyle(color: ShopColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75),
                itemCount: mockProducts.length,
                itemBuilder: (_, i) => ProductCard(product: mockProducts[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
