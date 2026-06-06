// lib/features/shop/screens/widgets/stores_section.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/widgets/store_card.dart';

class StoresSection extends StatelessWidget {
  const StoresSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stores = StoreModel.getMockStores().take(3).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Top Stores', style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Text('View All',
                style: TextStyle(color: ShopColors.accent))),
          ])),
      SizedBox(height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: stores.length,
          itemBuilder: (_, i) => SizedBox(width: 280,
            child: Padding(padding: const EdgeInsets.all(8),
              child: StoreCard(store: stores[i]))))),
    ]);
  }
}

