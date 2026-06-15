import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_products.dart';
import '../widgets/product_card.dart';

class UserShopScreen extends StatelessWidget {
  final String userName;
  const UserShopScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 16),
            const CircleAvatar(radius: 40, backgroundColor: ShopColors.surface, child: Icon(Icons.store, size: 40, color: ShopColors.accent)),
            const SizedBox(height: 8),
            Text('متجر $userName', style: const TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('20 منتج | 120 متابع', style: TextStyle(color: ShopColors.text2)),
            const SizedBox(height: 16),
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
    ]),
  );
}
