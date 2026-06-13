import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellerInfoCard extends StatelessWidget {
  final String sellerName;
  final double rating;
  final int productCount;

  const SellerInfoCard({
    super.key,
    required this.sellerName,
    required this.rating,
    required this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        CircleAvatar(backgroundColor: ShopColors.accent.withOpacity(0.1), child: const Icon(Icons.store, color: ShopColors.accent)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(sellerName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
          Text('$productCount منتج • تقييم $rating', style: const TextStyle(color: ShopColors.text2)),
        ])),
      ]),
    );
  }
}
