import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BoostProductScreen extends StatelessWidget {
  const BoostProductScreen({super.key});

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
                child: Column(children: const [
                  Text('ترويج المنتج', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('اختر خطة الترويج المناسبة لزيادة ظهور منتجك.', style: TextStyle(color: ShopColors.text2)),
                ]),
              ),
              const SizedBox(height: 20),
              _buildPlan('يوم واحد', 5.0),
              _buildPlan('3 أيام', 12.0),
              _buildPlan('أسبوع', 25.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlan(String duration, double price) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: ShopColors.border)),
    child: Row(children: [
      Text(duration, style: const TextStyle(color: ShopColors.text)),
      const Spacer(),
      Text('\$$price', style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w800)),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
          child: const Text('اختيار', style: TextStyle(color: Colors.white)),
        ),
      ),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('ترويج', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
