import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ShippingInfoScreen extends StatelessWidget {
  const ShippingInfoScreen({super.key});

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
                child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('معلومات الشحن', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('- توصيل عادي: 3-5 أيام عمل (مجاني للطلبات فوق 100 دج)', style: TextStyle(color: ShopColors.text2)),
                  Text('- توصيل سريع: 1-2 يوم عمل (رسوم إضافية)', style: TextStyle(color: ShopColors.text2)),
                  Text('- التوصيل للمدن الكبرى: الجزائر، وهران، قسنطينة', style: TextStyle(color: ShopColors.text2)),
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
    const Text('الشحن', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
