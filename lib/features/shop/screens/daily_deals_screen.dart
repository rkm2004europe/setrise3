import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_products.dart';
import '../widgets/product_card.dart';

class DailyDealsScreen extends StatelessWidget {
  const DailyDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام نفس المنتجات مع خصومات إضافية
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('⚡ عروض اليوم - لفترة محدودة', style: TextStyle(color: ShopColors.accent, fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75),
                itemCount: mockProducts.length,
                itemBuilder: (_, i) => ProductCard(product: mockProducts[i]),
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
      const Text('عروض اليوم', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
