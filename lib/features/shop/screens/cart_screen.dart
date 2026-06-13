import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للسلة
    final items = [
      CartItemModel(product: ProductModel(
        id: 'p1', name: 'هاتف ذكي Pro Max', description: '', price: 1200, images: ['📱'], category: '', sellerId: '', sellerName: '', rating: 0, reviewCount: 0, stock: 1,
      ), quantity: 1),
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
                itemBuilder: (_, i) => CartItemWidget(item: items[i]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: ShopColors.surface, border: Border(top: BorderSide(color: ShopColors.border))),
              child: Row(
                children: [
                  const Text('الإجمالي: ', style: TextStyle(color: ShopColors.text, fontSize: 18)),
                  const Spacer(),
                  Text('\$${items.fold(0.0, (sum, e) => sum + e.totalPrice)}',
                      style: const TextStyle(color: ShopColors.accent, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                      child: const Text('الدفع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
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
      const Text('عربة التسوق', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
