import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.favorite_border, color: ShopColors.text2, size: 64),
        const SizedBox(height: 16),
        const Text('قائمة الأمنيات فارغة', style: TextStyle(color: ShopColors.text, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('أضف منتجات إلى قائمتك المفضلة', style: TextStyle(color: ShopColors.text2)),
      ]),
    );
  }
}
