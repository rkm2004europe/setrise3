import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ShopProfileScreen extends StatelessWidget {
  final String sellerName;
  const ShopProfileScreen({super.key, required this.sellerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            const CircleAvatar(radius: 40, backgroundColor: ShopColors.surface, child: Icon(Icons.store, size: 40, color: ShopColors.accent)),
            const SizedBox(height: 12),
            Text(sellerName, style: const TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('تقييم 4.5 | 230 منتج', style: TextStyle(color: ShopColors.text2)),
            const SizedBox(height: 20),
            // أزرار متابعة المتجر
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(20)),
                child: const Text('متابعة المتجر', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    ]),
  );
}
