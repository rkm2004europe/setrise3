import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WarrantyInfoScreen extends StatelessWidget {
  const WarrantyInfoScreen({super.key});

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
                  Text('سياسة الضمان', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('- ضمان سنة ضد عيوب التصنيع.', style: TextStyle(color: ShopColors.text2)),
                  Text('- الضمان لا يشمل سوء الاستخدام.', style: TextStyle(color: ShopColors.text2)),
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
    const Text('الضمان', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
