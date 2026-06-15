import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WalletPaymentScreen extends StatelessWidget {
  final double amount;
  const WalletPaymentScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Icon(Icons.account_balance_wallet, size: 64, color: ShopColors.accent),
                  const SizedBox(height: 12),
                  Text('الدفع بالمحفظة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('رصيدك: \$500.00', style: TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 4),
                  Text('المبلغ المطلوب: \$${amount.toStringAsFixed(2)}', style: TextStyle(color: ShopColors.accent, fontSize: 18, fontWeight: FontWeight.w600)),
                ]),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تأكيد الدفع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('الدفع بالمحفظة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
