// lib/features/shop/screens/cart_screen.dart
//
// شاشة سلة التسوق — تعرض العناصر، الإجمالي، زر الدفع
//
// الإصلاحات:
//   - ربط السلة بـ CartService (Singleton) بدل البيانات الوهمية
//   - استخدام StatefulWidget للاستماع لتغييرات السلة
//   - ربط زر الدفع بـ PaymentMethodsScreen
//   - عرض EmptyCart عند الفراغ
//   - حساب الإجمالي من CartService.subtotal

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/cart_item.dart';
import '../widgets/empty_cart.dart';
import '../services/cart_service.dart';
import 'payment_methods_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cart = CartService();

  @override
  void initState() {
    super.initState();
    _cart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = _cart.itemsList;

    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            if (items.isEmpty)
              const Expanded(child: EmptyCart())
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, i) => CartItemWidget(
                    item: items[i],
                    onChanged: _onCartChanged,
                  ),
                ),
              ),
            if (items.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ShopColors.surface,
                  border: Border(
                    top: BorderSide(color: ShopColors.border),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'الإجمالي: ',
                      style: TextStyle(color: ShopColors.text, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      '\$${_cart.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: ShopColors.accent,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentMethodsScreen(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: ShopColors.accent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'الدفع',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: ShopColors.text),
            ),
            const SizedBox(width: 12),
            const Text(
              'عربة التسوق',
              style: TextStyle(
                color: ShopColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            if (_cart.itemsList.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _cart.clear();
                  _onCartChanged();
                },
                child: const Text(
                  'تفريغ',
                  style: TextStyle(color: ShopColors.red, fontSize: 13),
                ),
              ),
          ],
        ),
      );
}
