// lib/features/shop/screens/auction/orders_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text('My Orders',
          style: TextStyle(color: CupertinoColors.white))),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _OrderCard(id: 'ORD-001', status: 'Delivered', total: 249.98, items: 2),
            _OrderCard(id: 'ORD-002', status: 'Processing', total: 89.99, items: 1),
            _OrderCard(id: 'ORD-003', status: 'Shipped', total: 349.00, items: 1),
          ])),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String id, status;
  final double total;
  final int items;

  const _OrderCard({
    required this.id, required this.status,
    required this.total, required this.items,
  });

  Color get _statusColor {
    switch (status) {
      case 'Delivered':  return ShopColors.green;
      case 'Processing': return ShopColors.accent;
      case 'Shipped':    return ShopColors.blue;
      default:           return ShopColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ShopColors.surface,
        borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(id, style: const TextStyle(
            color: ShopColors.grey, fontSize: 13)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
            child: Text(status, style: TextStyle(
              color: _statusColor, fontSize: 12,
              fontWeight: FontWeight.bold))),
        ]),
        const SizedBox(height: 8),
        Text('$items items • \$${total.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: ShopColors.grey2,
            onPressed: () {},
            child: const Text('Track'))),
          const SizedBox(width: 12),
          Expanded(child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: ShopColors.accent,
            onPressed: () {},
            child: Text(status == 'Delivered' ? 'Review' : 'Reorder',
              style: const TextStyle(color: Colors.black)))),
        ]),
      ]),
    );
  }
}

