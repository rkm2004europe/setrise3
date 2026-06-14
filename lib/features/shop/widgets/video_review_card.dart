import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class VideoReviewCard extends StatelessWidget {
  final String userName;
  final String thumbnailEmoji;
  final int viewsCount;

  const VideoReviewCard({
    super.key,
    required this.userName,
    required this.thumbnailEmoji,
    required this.viewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: ShopColors.accent.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Stack(
              children: [
                Center(child: Text(thumbnailEmoji, style: const TextStyle(fontSize: 48))),
                const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 36)),
                Positioned(bottom: 8, right: 8, child: Text('$viewsCount', style: const TextStyle(color: Colors.white, fontSize: 11))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(userName, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
