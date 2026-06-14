import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_auctions.dart';

class LiveAuctionScreen extends StatelessWidget {
  const LiveAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final active = mockAuctions.where((a) => a.isActive).toList();
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: active.length,
                itemBuilder: (_, i) => ListTile(
                  leading: Text(active[i].image, style: const TextStyle(fontSize: 32)),
                  title: Text(active[i].productName, style: const TextStyle(color: ShopColors.text)),
                  subtitle: Text('السعر الحالي: \$${active[i].currentBid}', style: const TextStyle(color: ShopColors.accent)),
                  onTap: () {},
                ),
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
      const Text('المزادات المباشرة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
