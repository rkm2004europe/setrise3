// lib/features/shop/screens/widgets/live_auctions_section.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/auction/widgets/auction_grid_card.dart';
import 'package:setrise/features/shop/screens/auction/auction_screen.dart';

class LiveAuctionsSection extends StatelessWidget {
  const LiveAuctionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final auctions = AuctionItem.getMockAuctions().take(3).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Live Auctions', style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.push(context,
                CupertinoPageRoute(builder: (_) => const AuctionScreen())),
              child: const Text('View All',
                style: TextStyle(color: ShopColors.accent))),
          ])),
      SizedBox(height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: auctions.length,
          itemBuilder: (_, i) => SizedBox(width: 160,
            child: Padding(padding: const EdgeInsets.all(8),
              child: AuctionGridCard(auction: auctions[i]))))),
    ]);
  }
}

