import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellerProductCard extends StatelessWidget {
  final String productName;
  final String imageEmoji;
  final double price;
  final int stock;
  final VoidCallback onTap;

  const SellerProductCard({
    super.key,
    required this.productName,
    required this.imageEmoji,
    required this.price,
    required this.stock,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Text(imageEmoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(productName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
            Text('\$$price', style: const TextStyle(color: ShopColors.accent)),
          ])),
          Text('المخزون: $stock', style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
        ]),
      ),
    );
  }
}
