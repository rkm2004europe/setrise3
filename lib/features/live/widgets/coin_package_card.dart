import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CoinPackageCard extends StatelessWidget {
  final int coins;
  final double price;
  final VoidCallback onBuy;

  const CoinPackageCard({super.key, required this.coins, required this.price, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LiveColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: LiveColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: LiveColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.monetization_on, color: LiveColors.gold, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$coins 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 20, fontWeight: FontWeight.w800)),
                Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(color: LiveColors.text2)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onBuy,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: LiveColors.accent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text('شراء', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
