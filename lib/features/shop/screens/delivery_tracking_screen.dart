import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DeliveryTrackingScreen extends StatelessWidget {
  const DeliveryTrackingScreen({super.key});

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
                  const Icon(Icons.local_shipping, color: ShopColors.accent, size: 48),
                  const SizedBox(height: 12),
                  const Text('طلبك في الطريق!', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text('رقم التتبع: TRK12345', style: TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(value: 0.6, color: ShopColors.accent),
                  const SizedBox(height: 10),
                  const Text('المسافة المتبقية: 2 كم', style: TextStyle(color: ShopColors.text2)),
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
    const Text('تتبع التوصيل', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
