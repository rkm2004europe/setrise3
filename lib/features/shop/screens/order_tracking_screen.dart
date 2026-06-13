import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/order_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildStatusCard(),
              if (order.trackingNumber != null) ...[
                const SizedBox(height: 20),
                _buildSection('رقم التتبع', order.trackingNumber!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('تتبع الطلب', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);

  Widget _buildStatusCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(children: [
      Text(order.productName, style: const TextStyle(color: ShopColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Text('الحالة: ${order.status.name}', style: const TextStyle(color: ShopColors.accent)),
    ]),
  );

  Widget _buildSection(String title, String content) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: ShopColors.text2)),
      const SizedBox(height: 6),
      Text(content, style: const TextStyle(color: ShopColors.text)),
    ]),
  );
}
