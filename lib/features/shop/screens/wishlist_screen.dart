// lib/features/shop/screens/wishlist_screen.dart
//
// شاشة قائمة الأمنيات — تعرض المنتجات المحفوظة
//
// الإصلاحات:
//   - ربط القائمة بـ WishlistController (Singleton) بدل mockProducts
//   - استخدام StatefulWidget للاستماع للتغييرات
//   - عرض EmptyWishlist عند الفراغ
//   - زر تفريغ في الترويسة

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/product_card.dart';
import '../widgets/empty_wishlist.dart';
import '../controllers/wishlist_controller.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final _wishlist = WishlistController();

  @override
  void initState() {
    super.initState();
    _wishlist.addListener(_onChanged);
  }

  @override
  void dispose() {
    _wishlist.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = _wishlist.items;

    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            if (items.isEmpty)
              const Expanded(child: EmptyWishlist())
            else
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, i) => ProductCard(product: items[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: ShopColors.text),
            ),
            const SizedBox(width: 12),
            const Text(
              'قائمة الأمنيات',
              style: TextStyle(
                color: ShopColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            if (_wishlist.size > 0)
              Text(
                '(${_wishlist.size})',
                style: const TextStyle(color: ShopColors.text2, fontSize: 14),
              ),
            const Spacer(),
            if (_wishlist.size > 0)
              GestureDetector(
                onTap: () => _wishlist.clear(),
                child: const Text(
                  'تفريغ',
                  style: TextStyle(color: ShopColors.red, fontSize: 13),
                ),
              ),
          ],
        ),
      );
}
