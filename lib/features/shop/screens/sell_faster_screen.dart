import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellFasterScreen extends StatelessWidget {
  const SellFasterScreen({super.key});

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
              _buildTip('صور واضحة', 'استخدم صورًا عالية الجودة لمنتجك.'),
              _buildTip('وصف دقيق', 'اكتب وصفًا مفصلاً يجيب على أسئلة المشتري.'),
              _buildTip('سعر منافس', 'حدد سعرًا معقولاً مقارنة بالمنتجات المشابهة.'),
            ],
          ),
        ),
      );
  }

  Widget _buildTip(String title, String description) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w700)),
      Text(description, style: const TextStyle(color: ShopColors.text2)),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('نصائح للبيع', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
      }
