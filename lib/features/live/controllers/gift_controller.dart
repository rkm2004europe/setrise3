import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_coins.dart';

class CoinBalanceWidget extends StatelessWidget {
  const CoinBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.monetization_on, color: LiveColors.gold, size: 16),
        const SizedBox(width: 4),
        Text('$mockUserCoins', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
