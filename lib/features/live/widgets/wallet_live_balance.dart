import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../wallet/data/mock_wallet.dart';

class WalletLiveBalance extends StatelessWidget {
  const WalletLiveBalance({super.key});

  @override
  Widget build(BuildContext context) {
    // ربط مع wallet/ الحقيقي
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.account_balance_wallet, color: LiveColors.accent, size: 18),
        const SizedBox(width: 6),
        Text('رصيد المحفظة: \$12.50', style: const TextStyle(color: LiveColors.text, fontSize: 12)),
      ]),
    );
  }
}
