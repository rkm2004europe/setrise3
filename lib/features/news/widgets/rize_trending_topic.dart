import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_trending_model.dart';

class RizeTrendingTopic extends StatelessWidget {
  final RizeTrendingModel topic;
  final VoidCallback onTap;

  const RizeTrendingTopic({
    super.key,
    required this.topic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: NewsColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: NewsColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
                  Text('${topic.postsCount} posts', style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            if (topic.hashtag != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: NewsColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(topic.hashtag!, style: const TextStyle(color: NewsColors.accent, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}
