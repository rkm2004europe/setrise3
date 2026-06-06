// lib/features/shop/screens/cart/widgets/coupon_section_cart.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class CouponSectionCart extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;
  final double discount;
  final bool enabled;

  const CouponSectionCart({
    super.key, required this.controller, required this.onApply,
    required this.discount, required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Expanded(child: CupertinoTextField(
          controller: controller, enabled: enabled,
          placeholder: 'Coupon code',
          style: const TextStyle(color: Colors.white),
          decoration: BoxDecoration(
            color: ShopColors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)))),
        const SizedBox(width: 12),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: enabled ? ShopColors.accent : ShopColors.grey,
          onPressed: enabled ? onApply : null,
          child: const Text('Apply')),
        if (discount > 0) ...[
          const SizedBox(width: 8),
          Text('-\$${discount.toStringAsFixed(2)}',
            style: const TextStyle(color: ShopColors.green,
              fontWeight: FontWeight.bold)),
        ],
      ]),
    );
  }
}

