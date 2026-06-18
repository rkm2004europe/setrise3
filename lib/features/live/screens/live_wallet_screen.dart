import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'coin_shop_screen.dart';
import 'withdraw_screen.dart';
import '../../wallet/screens/wallet_home_screen.dart';

class LiveWalletScreen extends StatelessWidget {
  const LiveWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [LiveColors.gold.withOpacity(0.3), LiveColors.surface]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  const Icon(Icons.monetization_on, size: 48, color: LiveColors.gold),
                  const SizedBox(height: 10),
                  const Text('250 🪙', style: TextStyle(color: LiveColors.gold, fontSize: 32, fontWeight: FontWeight.w900)),
                  const Text('رصيدك الحالي', style: TextStyle(color: LiveColors.text2)),
                ]),
              ),
              const SizedBox(height: 20),
              _btn('شراء عملات', Icons.add_shopping_cart, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CoinShopScreen()))),
              _btn('سحب الأرباح', Icons.credit_card, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WithdrawScreen()))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(String label, IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Icon(icon, color: LiveColors.accent),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: LiveColors.text2),
          ]),
        ),
      );

  Widget _buildTopBar(BuildContext context) => Row(children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
        const SizedBox(width: 12),
        const Text('محفظة Live', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
      ]);
}
