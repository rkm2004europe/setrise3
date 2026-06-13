import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';

class AuctionDetailScreen extends StatefulWidget {
  final AuctionModel auction;
  const AuctionDetailScreen({super.key, required this.auction});

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  double _bidAmount = 0;

  void _placeBid() {
    HapticFeedback.mediumImpact();
    setState(() {
      widget.auction.currentBid += 10;
      widget.auction.highestBidderId = 'me';
      widget.auction.bidderIds.add('me');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت المزايدة! السعر الجديد: \$${widget.auction.currentBid}'), backgroundColor: ShopColors.accent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(widget.auction.image, style: const TextStyle(fontSize: 100)),
                    const SizedBox(height: 16),
                    Text(widget.auction.productName, style: const TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('السعر الحالي: \$${widget.auction.currentBid}', style: const TextStyle(color: ShopColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text('المزايدين: ${widget.auction.bidderIds.length}', style: const TextStyle(color: ShopColors.text2)),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: _placeBid,
                      child: Container(
                        width: double.infinity, height: 52,
                        decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(16)),
                        child: const Center(child: Text('مزايدة سريعة + \$10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('تفاصيل المزاد', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
