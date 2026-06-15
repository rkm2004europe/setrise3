import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PriceHistoryScreen extends StatelessWidget {
  const PriceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('📈', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text('سجل الأسعار', style: TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('أدنى سعر خلال 30 يوم: \$150\nأعلى سعر: \$200', style: TextStyle(color: ShopColors.text2)),
                ]),
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
      const SizedBox(width: 12),
      const Text('تاريخ السعر', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
