import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BuyTogetherScreen extends StatelessWidget {
  const BuyTogetherScreen({super.key});

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
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Text('اشتري معًا ووفر', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: Center(child: Text('📱', style: TextStyle(fontSize: 48)))),
                    const Icon(Icons.add, color: ShopColors.text2),
                    Expanded(child: Center(child: Text('🎧', style: TextStyle(fontSize: 48)))),
                  ]),
                  const SizedBox(height: 12),
                  Text('\$150 بدلاً من \$180', style: TextStyle(color: ShopColors.accent, fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
                      child: const Center(child: Text('أضف الاثنين للسلة', style: TextStyle(color: Colors.white))),
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
    const Text('اشتري معًا', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
