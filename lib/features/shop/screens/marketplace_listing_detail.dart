import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/marketplace_listing_model.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart' as chat;

class MarketplaceListingDetail extends StatelessWidget {
  final MarketplaceListingModel listing;
  const MarketplaceListingDetail({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildTopBar(context),
            const SizedBox(height: 16),
            Text(listing.title, style: const TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('\$${listing.price}', style: const TextStyle(color: ShopColors.accent, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(listing.description, style: const TextStyle(color: ShopColors.text2)),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.person, color: ShopColors.text2, size: 16),
              const SizedBox(width: 4),
              Text(listing.sellerName, style: const TextStyle(color: ShopColors.text2)),
              const Spacer(),
              Text(listing.location, style: const TextStyle(color: ShopColors.text2)),
            ]),
            const Spacer(),
            GestureDetector(
              onTap: () {
                final conv = chat.Conversation(
                  id: 'market_${listing.id}',
                  user: chat.User(id: listing.sellerId, name: listing.sellerName, username: '@${listing.sellerName}', avatar: '🏪', type: chat.ConvType.friend),
                  type: chat.ConvType.friend,
                  lastMessage: null, unread: 0, isArchived: false, isMuted: false, updatedAt: DateTime.now(),
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => chat.ChatScreen(conversation: conv)));
              },
              child: Container(
                width: double.infinity, height: 52,
                decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                child: const Center(child: Text('مراسلة البائع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
  ]);
}
