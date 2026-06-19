import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/coin_controller.dart';

class CoinBalanceWidget extends StatelessWidget {
  final CoinController controller;
  const CoinBalanceWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/live/wallet'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.monetization_on, color: LiveColors.gold, size: 16),
          const SizedBox(width: 4),
          Text('${controller.balance}', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }
}
