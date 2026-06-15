import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class GiftCardWidget extends StatelessWidget {
  final double amount;
  const GiftCardWidget({super.key, required this.amount});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: ShopColors.border)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.card_giftcard, color: ShopColors.accent, size: 32),
      const SizedBox(height: 8),
      Text('\$${amount.toInt()}', style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
    ]),
  );
}
