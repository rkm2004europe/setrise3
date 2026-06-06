// lib/features/shop/screens/cart/cart_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/services/cart_service.dart';
import 'package:setrise/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:setrise/features/shop/screens/cart/widgets/coupon_section_cart.dart';
import 'package:setrise/features/shop/screens/cart/widgets/order_summary_cart.dart';
import 'package:setrise/features/shop/screens/cart/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  final _couponCtrl = TextEditingController();
  double _couponDiscount = 0.0;

  @override
  void dispose() { _couponCtrl.dispose(); super.dispose(); }

  void _applyCoupon() {
    if (_couponCtrl.text.trim().toUpperCase() == 'SAVE10') {
      setState(() => _couponDiscount = _cartService.subtotal * 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('Cart', style: TextStyle(color: Colors.black))),
      child: ValueListenableBuilder<List<CartItem>>(
        valueListenable: _cartService.items,
        builder: (_, items, __) {
          if (items.isEmpty) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(CupertinoIcons.cart, size: 60, color: ShopColors.grey),
              const SizedBox(height: 12),
              const Text('Your cart is empty',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            ]));
          }
          final subtotal = items.fold(0.0,
            (sum, item) => sum + item.price * item.quantity);
          final shipping = subtotal > 100 ? 0.0 : 5.99;
          final total = subtotal - _couponDiscount + shipping;

          return Column(children: [
            Expanded(child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                return CartItemWidget(
                  imageUrl: item.imageUrl, brand: item.brand,
                  name: item.name, price: item.price, quantity: item.quantity,
                  onDecrement: () =>
                    _cartService.updateQuantity(item.id, item.quantity - 1),
                  onIncrement: () =>
                    _cartService.updateQuantity(item.id, item.quantity + 1));
              })),
            CouponSectionCart(
              controller: _couponCtrl, onApply: _applyCoupon,
              discount: _couponDiscount, enabled: _couponDiscount == 0),
            OrderSummaryCart(
              subtotal: subtotal, shipping: shipping,
              discount: _couponDiscount, total: total,
              onCheckout: () => Navigator.push(context,
                CupertinoPageRoute(builder: (_) => CheckoutScreen(
                  subtotal: subtotal, shippingCost: shipping,
                  tax: 0, total: total)))),
          ]);
        },
      ),
    );
  }
}

