import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AffiliateScreen extends StatelessWidget {
  const AffiliateScreen({super.key});

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
                  const Text('برنامج التسويق بالعمولة', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text('اربح 10% من كل عملية شراء عبر رابطك.', style: TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 16),
                  const Text('رابط الإحالة الخاص بك:', style: TextStyle(color: ShopColors.text2, fontSize: 12)),
                  Text('https://setrise.shop/ref/yourID', style: TextStyle(color: ShopColors.accent, fontSize: 14)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
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

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('التسويق بالعمولة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
