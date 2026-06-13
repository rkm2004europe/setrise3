import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(order.productName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
              Text('\$${order.amount} • ${order.status.name}', style: const TextStyle(color: ShopColors.text2)),
            ]),
          ),
          if (order.trackingNumber != null)
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.local_shipping, color: ShopColors.accent),
            ),
        ],
      ),
    );
  }
}
