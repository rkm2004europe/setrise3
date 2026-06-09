import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_space_model.dart';

class RizeSpaceCard extends StatelessWidget {
  final RizeSpaceModel space;
  final VoidCallback onJoin;
  const RizeSpaceCard({super.key, required this.space, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: space.isLive ? NewsColors.accent.withOpacity(0.05) : NewsColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: space.isLive ? NewsColors.accent.withOpacity(0.3) : NewsColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: space.isLive ? NewsColors.accent.withOpacity(0.1) : NewsColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic, color: space.isLive ? NewsColors.accent : NewsColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(space.title, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
                Text('${space.hostUserName} • ${space.listenersCount} listeners',
                    style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          if (space.isLive)
            GestureDetector(
              onTap: onJoin,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: NewsColors.accent, borderRadius: BorderRadius.circular(20)),
                child: const Text('Join', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
        ],
      ),
    );
  }
}
