// lib/features/shop/screens/cart/widgets/order_summary_section.dart

import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class OrderSummarySection extends StatelessWidget {
  final double subtotal, shipping, tax, discount, total;
  final bool couponApplied;

  const OrderSummarySection({
    super.key, required this.subtotal, required this.shipping,
    required this.tax, required this.discount, required this.total,
    required this.couponApplied,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ShopColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _row('Subtotal', subtotal),
        _row('Shipping', shipping),
        _row('Tax', tax),
        if (couponApplied) _row('Discount', -discount, color: ShopColors.green),
        Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white12),
        _row('Total', total, bold: true),
      ]),
    );
  }

  Widget _row(String label, double amount, {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            color: color ?? ShopColors.grey2,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text('\$${amount.toStringAsFixed(2)}', style: TextStyle(
            color: color ?? Colors.white,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ]));
  }
}

