import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellOnSetRiseScreen extends StatelessWidget {
  const SellOnSetRiseScreen({super.key});

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
                  const Icon(Icons.storefront, size: 64, color: ShopColors.accent),
                  const SizedBox(height: 12),
                  const Text('ابدأ البيع على SetRise', style: TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('افتح متجرك الخاص وابدأ في بيع منتجاتك لملايين المستخدمين.', textAlign: TextAlign.center, style: TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity, height: 52,
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                      child: const Center(child: Text('سجل كبائع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
  ]);
}
