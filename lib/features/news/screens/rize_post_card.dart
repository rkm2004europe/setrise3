import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../../comment/screens/comments_screen.dart';
import '../../shar/screens/share_sheet.dart';
import '../../user/screens/user_preview_sheet.dart';
import 'media_viewer_screen.dart';

class RizePostCard extends StatelessWidget {
  final RizePostModel post;
  final Function(RizePostModel) onUpdate;

  const RizePostCard({
    super.key,
    required this.post,
    required this.onUpdate,
  });

  void _openComments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CommentsScreen(
          contextId: post.id,
          contextName: post.username,
          accent: NewsColors.accent,
          contextType: CommentContextType.post,
        ),
      ),
    );
  }

  void _openShare(BuildContext context) {
    ShareSheet.show(
      context,
      data: ShareData(
        id: post.id,
        title: post.userName,
        subtitle: post.text,
        accentColor: NewsColors.accent,
        link: 'https://setrise.app/rize/${post.id}',
      ),
    );
  }

  void _openUserPreview(BuildContext context) {
    showUserPreviewSheet(
      context,
      userId: post.userId,
      userName: post.userName,
      username: post.username,
      bio: 'Rize creator',
      followers: 1200,
      following: 300,
      postsCount: 45,
      accent: NewsColors.accent,
    );
  }

  void _openMediaViewer(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaViewerScreen(
          mediaUrls: post.mediaUrls,
          initialIndex: initialIndex,
          heroTag: 'rize_${post.id}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: NewsColors.cardBackground,
        border: Border(bottom: BorderSide(color: NewsColors.divider)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المستخدم
          GestureDetector(
            onTap: () => _openUserPreview(context),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: NewsColors.textHint.withOpacity(0.2),
              child: Text(
                post.userName[0].toUpperCase(),
                style: const TextStyle(
                  color: NewsColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم واليوزر
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _openUserPreview(context),
                      child: Text(
                        post.userName,
                        style: const TextStyle(
                          color: NewsColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post.username,
                      style: const TextStyle(
                        color: NewsColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _timeAgo(post.createdAt),
                      style: const TextStyle(
                        color: NewsColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // النص (250 حرف كحد أقصى)
                Text(
                  post.text,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: NewsColors.textPrimary,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                // عرض الوسائط (صورة/فيديو) بحجم ثابت
                if (post.mediaUrls.isNotEmpty && post.mediaType != null)
                  GestureDetector(
                    onTap: () => _openMediaViewer(context, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: 400, // ارتفاع مناسب
                        decoration: BoxDecoration(
                          color: NewsColors.surface,
                          border: Border.all(color: NewsColors.border),
                        ),
                        child: post.mediaType == RizeMediaType.audio
                            ? const Center(
                                child: Icon(Icons.music_note,
                                    size: 48, color: NewsColors.accent))
                            : Image.network(
                                post.mediaUrls[0],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                    Icons.broken_image,
                                    color: NewsColors.textSecondary),
                              ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                // أزرار التفاعل (مثل Threads)
                Row(
                  children: [
                    _ActionBtn(
                      icon: post.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: _formatCount(post.likes),
                      color: post.isLiked
                          ? NewsColors.likeActive
                          : NewsColors.textSecondary,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onUpdate(post.copyWith(
                            isLiked: !post.isLiked,
                            likes:
                                post.isLiked ? post.likes - 1 : post.likes + 1));
                      },
                    ),
                    const SizedBox(width: 20),
                    _ActionBtn(
                      icon: Icons.chat_bubble_outline,
                      label: _formatCount(post.comments),
                      color: NewsColors.textSecondary,
                      onTap: () => _openComments(context),
                    ),
                    const SizedBox(width: 20),
                    _ActionBtn(
                      icon: Icons.repeat,
                      label: _formatCount(post.shares),
                      color: NewsColors.repost,
                      onTap: () => _openShare(context),
                    ),
                    const Spacer(),
                    _ActionBtn(
                      icon: post.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      label: '',
                      color: post.isBookmarked
                          ? NewsColors.saveActive
                          : NewsColors.textSecondary,
                      onTap: () {
                        onUpdate(post.copyWith(
                            isBookmarked: !post.isBookmarked));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}
