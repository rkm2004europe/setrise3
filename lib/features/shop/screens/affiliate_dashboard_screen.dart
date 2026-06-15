import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AffiliateDashboardScreen extends StatelessWidget {
  const AffiliateDashboardScreen({super.key});

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
                _stat('الأرباح', '\$340'),
                const SizedBox(width: 12),
                _stat('النقرات', '1.2K'),
              ]),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('رابط الإحالة', style: TextStyle(color: ShopColors.text2, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text('https://setrise.shop/ref/yourID', style: TextStyle(color: ShopColors.accent, fontSize: 14)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(8)),
                      child: const Text('نسخ الرابط', style: TextStyle(color: Colors.white)),
                    ),
                  ),
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
    const Text('التسويق بالعمولة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
