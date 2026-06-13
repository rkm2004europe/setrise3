import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_reviews.dart';
import '../widgets/review_card.dart';

class SellerReviewsScreen extends StatelessWidget {
  final String sellerId;
  const SellerReviewsScreen({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    // ببساطة عرض كل التقييمات
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockReviews.length,
                itemBuilder: (_, i) => ReviewCard(review: mockReviews[i]),
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
      const Text('تقييمات البائع', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
