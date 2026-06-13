import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/order_model.dart';

class OrderStatusTracker extends StatelessWidget {
  final OrderStatus status;
  const OrderStatusTracker({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final steps = [OrderStatus.pending, OrderStatus.confirmed, OrderStatus.shipped, OrderStatus.delivered];
    final currentIndex = steps.indexOf(status);
    return Row(
      children: List.generate(steps.length, (i) {
        final isDone = i <= currentIndex;
        return Expanded(
          child: Row(children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: isDone ? ShopColors.accent : ShopColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: isDone ? ShopColors.accent : ShopColors.border),
              ),
              child: isDone ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
            ),
            if (i < steps.length - 1) Expanded(
              child: Container(height: 2, color: isDone ? ShopColors.accent : ShopColors.border),
            ),
          ]),
        );
      }),
    );
  }
}
