import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.shopping_cart_outlined, color: ShopColors.text2, size: 64),
        const SizedBox(height: 16),
        const Text('سلتك فارغة', style: TextStyle(color: ShopColors.text, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('ابدأ بالتسوق وأضف منتجات', style: TextStyle(color: ShopColors.text2)),
      ]),
    );
  }
}
