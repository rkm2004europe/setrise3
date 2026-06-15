import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_coupons.dart';
import '../widgets/cart_item.dart';

class AdvancedCartScreen extends StatefulWidget {
  const AdvancedCartScreen({super.key});

  @override
  State<AdvancedCartScreen> createState() => _AdvancedCartScreenState();
}

class _AdvancedCartScreenState extends State<AdvancedCartScreen> {
  String? _appliedCoupon;

  void _applyCoupon(String code) {
    setState(() => _appliedCoupon = code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CartItemWidget(item: CartItemModel(product: ProductModel(id: 'p1', name: 'هاتف ذكي Pro Max', description: '', price: 1200, images: ['📱'], category: '', sellerId: '', sellerName: '', rating: 0, reviewCount: 0, stock: 1))),
                  const SizedBox(height: 20),
                  // كوبونات متاحة
                  const Text('الكوبونات المتاحة', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...mockCoupons.map((c) => ListTile(
                    leading: const Icon(Icons.card_giftcard, color: ShopColors.accent),
                    title: Text(c['code'] as String, style: const TextStyle(color: ShopColors.text)),
                    subtitle: Text('خصم ${c['discount']}%', style: const TextStyle(color: ShopColors.text2)),
                    trailing: _appliedCoupon == c['code']
                        ? const Icon(Icons.check, color: ShopColors.green)
                        : TextButton(onPressed: () => _applyCoupon(c['code'] as String), child: const Text('تطبيق')),
                  )),
                  const SizedBox(height: 20),
                  // مشاركة السلة
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                      child: const Row(children: [
                        Icon(Icons.share, color: ShopColors.accent),
                        SizedBox(width: 10),
                        Text('مشاركة السلة', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: ShopColors.surface, border: Border(top: BorderSide(color: ShopColors.border))),
              child: Row(children: [
                const Text('الإجمالي: ', style: TextStyle(color: ShopColors.text, fontSize: 18)),
                const Spacer(),
                Text('\$${_appliedCoupon != null ? 1200 * (1 - (_appliedCoupon == 'BIG50' ? 0.5 : _appliedCoupon == 'SALE20' ? 0.2 : 0.1)) : 1200}', style: const TextStyle(color: ShopColors.accent, fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                    child: const Text('الدفع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ),
              ]),
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
      const Text('سلتي', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
