// lib/features/shop/screens/cart/widgets/order_summary_cart.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class OrderSummaryCart extends StatelessWidget {
  final double subtotal, shipping, discount, total;
  final VoidCallback onCheckout;

  const OrderSummaryCart({
    super.key, required this.subtotal, required this.shipping,
    required this.discount, required this.total, required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        _row('Subtotal', subtotal),
        _row('Shipping', shipping),
        if (discount > 0) _row('Discount', -discount, color: ShopColors.green),
        Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white12),
        _row('Total', total, bold: true),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity,
          child: CupertinoButton(
            color: ShopColors.accent,
            onPressed: onCheckout,
            child: Text('Checkout • \$${total.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold)))),
      ]),
    );
  }

  Widget _row(String label, double value, {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            color: color ?? ShopColors.grey2,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text('\$${value.toStringAsFixed(2)}', style: TextStyle(
            color: color ?? Colors.white,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ]));
  }
}

