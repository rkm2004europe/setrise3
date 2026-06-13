import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CouponCard extends StatelessWidget {
  final String code;
  final double discount;
  final bool isActive;

  const CouponCard({super.key, required this.code, required this.discount, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? ShopColors.accent : ShopColors.border),
      ),
      child: Row(children: [
        const Icon(Icons.card_giftcard, color: ShopColors.accent),
        const SizedBox(width: 10),
        Text(code, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text('خصم ${discount.toStringAsFixed(0)}%', style: const TextStyle(color: ShopColors.accent)),
      ]),
    );
  }
}
