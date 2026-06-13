import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';

class AuctionCard extends StatelessWidget {
  final AuctionModel auction;
  final VoidCallback onTap;

  const AuctionCard({super.key, required this.auction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final timeLeft = auction.timeLeft;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(width: 60, height: 60, decoration: BoxDecoration(color: ShopColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(auction.image, style: const TextStyle(fontSize: 32)))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(auction.productName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('السعر الحالي: \$${auction.currentBid}', style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w600)),
                if (auction.isActive)
                  Text('متبقي: ${timeLeft.inHours}h ${timeLeft.inMinutes % 60}m', style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
              ]),
            ),
            if (auction.isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
                child: const Text('مزايدة', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ),
    );
  }
}
