// lib/features/shop/screens/auction/saved_cards_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text('Payment Methods',
          style: TextStyle(color: CupertinoColors.white)),
        trailing: Icon(CupertinoIcons.add, color: ShopColors.accent)),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _CardTile(brand: 'VISA',   last4: '4242',
              expiry: '12/27', color: ShopColors.blue, isDefault: true),
            const SizedBox(height: 12),
            _CardTile(brand: 'MC',     last4: '1234',
              expiry: '08/26', color: Colors.orange),
          ])),
    );
  }
}

class _CardTile extends StatelessWidget {
  final String brand, last4, expiry;
  final Color color;
  final bool isDefault;

  const _CardTile({
    required this.brand, required this.last4,
    required this.expiry, required this.color, this.isDefault = false,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ShopColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: isDefault
        ? Border.all(color: ShopColors.accent, width: 1.5)
        : null),
    child: Row(children: [
      Container(
        width: 44, height: 28,
        decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text(brand,
          style: const TextStyle(color: Colors.white,
            fontSize: 10, fontWeight: FontWeight.w900)))),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('**** **** **** $last4',
          style: const TextStyle(color: Colors.white)),
        Text('Expires $expiry',
          style: const TextStyle(color: ShopColors.grey, fontSize: 13)),
      ])),
      if (isDefault)
        const Icon(CupertinoIcons.check_mark_circled,
          color: ShopColors.green)
      else
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Text('Set default',
            style: TextStyle(color: ShopColors.accent, fontSize: 12))),
    ]));
}
