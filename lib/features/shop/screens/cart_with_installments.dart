import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'installment_payment_screen.dart';

class CartWithInstallments extends StatelessWidget {
  const CartWithInstallments({super.key});

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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  const Row(children: [
                    Text('الإجمالي', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Text('\$1200', style: TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                        child: const Text('ادفع الآن', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InstallmentPaymentScreen(totalAmount: 1200))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: ShopColors.accent)),
                        child: const Text('تقسيط', style: TextStyle(color: ShopColors.accent)),
                      ),
                    ),
                  ]),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('السلة والتقسيط', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
