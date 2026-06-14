import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ImageReviewCard extends StatelessWidget {
  final String imageEmoji;
  final String userName;

  const ImageReviewCard({super.key, required this.imageEmoji, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ShopColors.surface),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(color: ShopColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(imageEmoji, style: const TextStyle(fontSize: 36))),
          ),
          const SizedBox(height: 4),
          Text(userName, style: const TextStyle(color: ShopColors.text2, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
