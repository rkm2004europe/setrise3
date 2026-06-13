import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/order_model.dart';
import '../data/mock_orders.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = mockOrders;
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStat('الطلبات', '${orders.length}'),
                  const SizedBox(width: 16),
                  _buildStat('الإيرادات', '\$1550'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('آخر الطلبات', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (_, i) => OrderCard(order: orders[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('لوحة البائع', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);

  Widget _buildStat(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Text(value, style: const TextStyle(color: ShopColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: ShopColors.text2)),
      ]),
    ),
  );
}
