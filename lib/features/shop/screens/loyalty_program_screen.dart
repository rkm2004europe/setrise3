import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LoyaltyProgramScreen extends StatelessWidget {
  const LoyaltyProgramScreen({super.key});

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
              const Icon(Icons.card_giftcard, size: 80, color: ShopColors.accent),
              const SizedBox(height: 16),
              const Text('برنامج الولاء', style: TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text('لديك 250 نقطة', style: TextStyle(color: ShopColors.accent, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: 0.5, color: ShopColors.accent, backgroundColor: ShopColors.surface),
              const SizedBox(height: 20),
              const Text('استبدل نقاطك:', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.discount, color: ShopColors.accent),
                title: const Text('خصم \$5', style: TextStyle(color: ShopColors.text)),
                subtitle: const Text('100 نقطة', style: TextStyle(color: ShopColors.text2)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.discount, color: ShopColors.accent),
                title: const Text('خصم \$15', style: TextStyle(color: ShopColors.text)),
                subtitle: const Text('250 نقطة', style: TextStyle(color: ShopColors.text2)),
                onTap: () {},
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
    const Text('برنامج الولاء', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
