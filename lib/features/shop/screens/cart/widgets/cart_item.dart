// lib/features/shop/screens/cart/widgets/cart_item.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl, brand, name;
  final double price;
  final int quantity;
  final VoidCallback onDecrement, onIncrement;

  const CartItemWidget({
    super.key, required this.imageUrl, required this.brand,
    required this.name, required this.price, required this.quantity,
    required this.onDecrement, required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ShopColors.surface,
        borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 60, height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 60, height: 60, color: ShopColors.card,
              child: const Icon(CupertinoIcons.photo,
                color: ShopColors.grey)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(brand, style: const TextStyle(color: ShopColors.grey, fontSize: 12)),
          Text(name, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('\$${(price * quantity).toStringAsFixed(2)}',
            style: const TextStyle(color: ShopColors.accent,
              fontWeight: FontWeight.w800)),
        ])),
        Column(children: [
          CupertinoButton(padding: EdgeInsets.zero,
            onPressed: onDecrement,
            child: const Icon(CupertinoIcons.minus_circle,
              color: ShopColors.grey)),
          Text('$quantity', style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700)),
          CupertinoButton(padding: EdgeInsets.zero,
            onPressed: onIncrement,
            child: const Icon(CupertinoIcons.add_circled,
              color: ShopColors.accent)),
        ]),
      ]),
    );
  }
}

