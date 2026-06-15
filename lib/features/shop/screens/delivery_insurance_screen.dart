import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DeliveryInsuranceScreen extends StatelessWidget {
  const DeliveryInsuranceScreen({super.key});

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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('تأمين الشحن', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  const Text('\$2.99', style: TextStyle(color: ShopColors.accent, fontSize: 24, fontWeight: FontWeight.w900)),
                  const Text('استرد كامل المبلغ في حال فقدان الشحنة.', style: TextStyle(color: ShopColors.text2)),
                ]),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('أضف التأمين', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('تأمين التوصيل', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
