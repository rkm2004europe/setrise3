// lib/features/shop/widgets/cart_item.dart
// مع أزرار +/−/حذف

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback? onChanged;

  const CartItemWidget({super.key, required this.item, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cart = CartService();
    final imageEmoji = item.product.images.isNotEmpty ? item.product.images[0] : '📦';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Text(imageEmoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                  style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('\$${item.product.price} × ${item.quantity}',
                  style: const TextStyle(color: ShopColors.text2, fontSize: 12)),
                const SizedBox(height: 8),
                Row(children: [
                  _qtyBtn(icon: Icons.remove, onTap: () {
                    cart.decrement(item.product.id);
                    onChanged?.call();
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('${item.quantity}',
                      style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                  ),
                  _qtyBtn(icon: Icons.add, onTap: () {
                    cart.increment(item.product.id);
                    onChanged?.call();
                  }),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      cart.removeFromCart(item.product.id);
                      onChanged?.call();
                    },
                    child: const Icon(Icons.delete_outline, color: ShopColors.red, size: 22),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('\$${item.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: ShopColors.bg, borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ShopColors.border)),
        child: Icon(icon, color: ShopColors.text, size: 16),
      ),
    );
  }
}
