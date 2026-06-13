import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: ShopColors.accent.withOpacity(0.1), child: Text(review.userName[0], style: const TextStyle(color: ShopColors.accent))),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(review.userName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                ...List.generate(review.rating.toInt(), (_) => const Icon(Icons.star, color: ShopColors.gold, size: 14)),
              ]),
              const SizedBox(height: 6),
              Text(review.comment, style: const TextStyle(color: ShopColors.text2)),
            ]),
          ),
        ],
      ),
    );
  }
}
