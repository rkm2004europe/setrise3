import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Text(item.product.images[0], style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.product.name, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('\$${item.product.price} x ${item.quantity}', style: const TextStyle(color: ShopColors.text2)),
            ]),
          ),
          Text('\$${item.totalPrice}', style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
