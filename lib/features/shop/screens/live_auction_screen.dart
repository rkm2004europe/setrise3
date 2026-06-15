import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';
import '../data/mock_auctions.dart';

class LiveAuctionScreen extends StatefulWidget {
  const LiveAuctionScreen({super.key});

  @override
  State<LiveAuctionScreen> createState() => _LiveAuctionScreenState();
}

class _LiveAuctionScreenState extends State<LiveAuctionScreen> {
  final AuctionModel auction = mockAuctions.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(auction.image, style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  Text(auction.productName, style: const TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('السعر الحالي: \$${auction.currentBid}', style: const TextStyle(color: ShopColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),
                  Text('المزايدون: ${auction.bidderIds.length}', style: const TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        auction.currentBid += 10;
                        auction.highestBidderId = 'me';
                        auction.bidderIds.add('me');
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                      child: const Text('مزايدة + \$10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('مزاد مباشر', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
