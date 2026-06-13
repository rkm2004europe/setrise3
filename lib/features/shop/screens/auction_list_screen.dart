import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_auctions.dart';
import '../widgets/auction_card.dart';
import 'auction_detail_screen.dart';

class AuctionListScreen extends StatelessWidget {
  const AuctionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockAuctions.length,
                itemBuilder: (_, i) => AuctionCard(
                  auction: mockAuctions[i],
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuctionDetailScreen(auction: mockAuctions[i]))),
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
      const Text('المزادات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
