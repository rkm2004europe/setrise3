import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellerAnalyticsScreen extends StatelessWidget {
  const SellerAnalyticsScreen({super.key});

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
              Row(children: [
                _stat('مبيعات اليوم', '\$450'),
                const SizedBox(width: 16),
                _stat('الزوار', '1.2K'),
              ]),
              const SizedBox(height: 20),
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('المبيعات اليومية', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [30, 80, 45, 90, 100, 60, 120].map((v) => Expanded(
                    child: Container(
                      height: v.toDouble(),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(4)),
                    ),
                  )).toList()),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Text(value, style: const TextStyle(color: ShopColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: ShopColors.text2)),
      ]),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('تحليلات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
