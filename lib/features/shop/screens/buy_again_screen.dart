import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/product_model.dart';

class BuyAgainScreen extends StatelessWidget {
  const BuyAgainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // منتجات سبق شراؤها (وهمية)
    final items = [
      ProductModel(id: 'p1', name: 'هاتف ذكي Pro Max', description: '', price: 1200, images: ['📱'], category: '', sellerId: '', sellerName: '', rating: 4.5, reviewCount: 230, stock: 1),
      ProductModel(id: 'p2', name: 'حذاء رياضي نايك', description: '', price: 350, images: ['👟'], category: '', sellerId: '', sellerName: '', rating: 4.2, reviewCount: 89, stock: 1),
    ];

    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    Text(items[i].images[0], style: const TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(items[i].name, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                      Text('\$${items[i].price}', style: const TextStyle(color: ShopColors.accent)),
                    ])),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
                        child: const Text('شراء', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
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
      const Text('إعادة الشراء', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
