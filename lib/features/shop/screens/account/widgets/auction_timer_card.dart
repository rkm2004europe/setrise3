// lib/features/shop/screens/auction/widgets/auction_timer_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class AuctionTimerCard extends StatelessWidget {
  final String timeLeft;
  final bool isEnded;

  const AuctionTimerCard({
    super.key, required this.timeLeft, required this.isEnded});

  @override
  Widget build(BuildContext context) {
    final color = isEnded ? ShopColors.red : Colors.orange;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ShopColors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Icon(CupertinoIcons.timer, color: color, size: 32),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Time Left',
            style: TextStyle(color: ShopColors.grey2, fontSize: 13)),
          Text(timeLeft, style: TextStyle(
            color: color, fontSize: 24,
            fontWeight: FontWeight.bold)),
        ]),
      ]),
    );
  }
}
