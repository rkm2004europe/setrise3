// lib/features/shop/screens/widgets/store_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  final VoidCallback? onTap;

  const StoreCard({super.key, required this.store, this.onTap});

  String _fmt(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ShopColors.card,
          borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Cover
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(store.coverUrl,
              height: 90, width: double.infinity, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 90, color: ShopColors.surface))),
          Padding(padding: const EdgeInsets.all(10), child: Row(children: [
            // Logo
            ClipRRect(borderRadius: BorderRadius.circular(8),
              child: Image.network(store.logoUrl,
                width: 40, height: 40, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 40, height: 40, color: ShopColors.surface,
                  child: Center(child: Text(store.name[0],
                    style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w900)))))),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(store.name, style: const TextStyle(color: Colors.white,
                fontWeight: FontWeight.w700, fontSize: 14)),
              Text(store.category, style: const TextStyle(
                color: ShopColors.grey, fontSize: 12)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: store.isFollowing
                    ? ShopColors.surface
                    : ShopColors.accent,
                borderRadius: BorderRadius.circular(12),
                border: store.isFollowing
                    ? Border.all(color: ShopColors.grey2)
                    : null),
              child: Text(store.isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  color: store.isFollowing ? ShopColors.grey : Colors.black,
                  fontSize: 12, fontWeight: FontWeight.w700))),
          ])),
          Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(children: [
              const Icon(CupertinoIcons.star_fill,
                  color: ShopColors.accent, size: 12),
              const SizedBox(width: 3),
              Text('${store.rating}', style: const TextStyle(
                color: Colors.white, fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(CupertinoIcons.cube_box,
                  color: ShopColors.grey, size: 12),
              const SizedBox(width: 3),
              Text('${store.products} products', style: const TextStyle(
                color: ShopColors.grey, fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(CupertinoIcons.person_2,
                  color: ShopColors.grey, size: 12),
              const SizedBox(width: 3),
              Text(_fmt(store.followers), style: const TextStyle(
                color: ShopColors.grey, fontSize: 12)),
            ])),
        ]),
      ),
    );
  }
}
