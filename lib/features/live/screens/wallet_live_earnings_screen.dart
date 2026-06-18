import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WalletLiveEarningsScreen extends StatelessWidget {
  const WalletLiveEarningsScreen({super.key});

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
                  gradient: LinearGradient(colors: [LiveColors.gold.withOpacity(0.2), LiveColors.surface]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  const Icon(Icons.account_balance_wallet, size: 48, color: LiveColors.gold),
                  const SizedBox(height: 12),
                  const Text('\$45.20', style: TextStyle(color: LiveColors.gold, fontSize: 32, fontWeight: FontWeight.w900)),
                  const Text('أرباحك من البثوث', style: TextStyle(color: LiveColors.text2)),
                ]),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('سحب الأرباح', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('أرباح البثوث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
