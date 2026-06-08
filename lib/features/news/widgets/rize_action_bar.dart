import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class RizeActionBar extends StatelessWidget {
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isBookmarked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onBookmark;

  const RizeActionBar({
    super.key,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.isBookmarked,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          label: _fmt(likesCount),
          color: isLiked ? NewsColors.likeActive : NewsColors.textSecondary,
          onTap: () {
            HapticFeedback.lightImpact();
            onLike();
          },
        ),
        const SizedBox(width: 20),
        _ActionBtn(
          icon: Icons.chat_bubble_outline,
          label: _fmt(commentsCount),
          color: NewsColors.textSecondary,
          onTap: onComment,
        ),
        const SizedBox(width: 20),
        _ActionBtn(
          icon: Icons.repeat,
          label: _fmt(sharesCount),
          color: NewsColors.repost,
          onTap: onShare,
        ),
        const Spacer(),
        _ActionBtn(
          icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          label: '',
          color: isBookmarked ? NewsColors.saveActive : NewsColors.textSecondary,
          onTap: onBookmark,
        ),
      ],
    );
  }

  String _fmt(int n) {
    if (n <= 0) return '';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}
