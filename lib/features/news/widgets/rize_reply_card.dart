import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_reply_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class RizeReplyCard extends StatelessWidget {
  final RizeReplyModel reply;
  final int depth;

  const RizeReplyCard({
    super.key,
    required this.reply,
    this.depth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 40.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: NewsColors.divider),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _openUser(context),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: NewsColors.accent.withOpacity(0.1),
                child: Text(
                  reply.userName[0].toUpperCase(),
                  style: const TextStyle(
                    color: NewsColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _openUser(context),
                        child: Text(
                          reply.userName,
                          style: const TextStyle(
                            color: NewsColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reply.username,
                        style: const TextStyle(
                          color: NewsColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _timeAgo(reply.createdAt),
                        style: const TextStyle(
                          color: NewsColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reply.text,
                    style: const TextStyle(
                      color: NewsColors.textPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _ActionBtn(
                        icon: reply.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: _formatCount(reply.likes),
                        color: reply.isLiked
                            ? NewsColors.likeActive
                            : NewsColors.textSecondary,
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      _ActionBtn(
                        icon: Icons.reply,
                        label: 'Reply',
                        color: NewsColors.textSecondary,
                        onTap: () {},
                      ),
                    ],
                  ),
                  if (reply.replies.isNotEmpty)
                    ...reply.replies.map(
                      (r) => RizeReplyCard(
                        reply: r,
                        depth: depth + 1,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openUser(BuildContext context) {
    showUserPreviewSheet(
      context,
      userId: reply.userId,
      userName: reply.userName,
      username: reply.username,
      accent: NewsColors.accent,
    );
  }

  String _timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }

  String _formatCount(int n) {
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

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 3),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
