import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_comment_model.dart';
import '../models/vip_tier_model.dart';
import 'vip_badge.dart';
import '../../user/screens/user_preview_sheet.dart';

class VipChatMessage extends StatelessWidget {
  final LiveCommentModel comment;
  final VipTier tier;

  const VipChatMessage({super.key, required this.comment, required this.tier});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showUserPreviewSheet(
        context,
        userId: comment.userId,
        userName: comment.userName,
        username: '@${comment.userName}',
        accent: LiveColors.accent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: tier == VipTier.host || tier == VipTier.moderator
              ? LiveColors.accent.withOpacity(0.15)
              : Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: tier != VipTier.normal
              ? Border.all(color: LiveColors.gold.withOpacity(0.4), width: 1)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            VipBadge(tier: tier),
            const SizedBox(width: 4),
            Text(
              comment.userName,
              style: TextStyle(
                color: tier != VipTier.normal ? LiveColors.gold : LiveColors.text,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: comment.isGift
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(comment.giftEmoji ?? '🎁', style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 2),
                        Text(comment.text, style: const TextStyle(color: LiveColors.gold, fontSize: 12)),
                      ],
                    )
                  : Text(
                      comment.text,
                      style: const TextStyle(color: LiveColors.text, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
