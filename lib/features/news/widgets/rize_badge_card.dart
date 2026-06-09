Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_badge_model.dart';

class RizeBadgeCard extends StatelessWidget {
  final RizeBadgeModel badge;
  const RizeBadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: badge.isEarned ? NewsColors.accent.withOpacity(0.1) : NewsColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: badge.isEarned ? NewsColors.accent.withOpacity(0.3) : NewsColors.border),
      ),
      child: Row(
        children: [
          Text(badge.icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(badge.name, style: TextStyle(color: badge.isEarned ? NewsColors.accent : NewsColors.textSecondary, fontWeight: FontWeight.w700)),
                Text(badge.description, style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          if (!badge.isEarned)
            const Icon(Icons.lock, color: NewsColors.textSecondary, size: 18),
        ],
      ),
    );
  }
}
