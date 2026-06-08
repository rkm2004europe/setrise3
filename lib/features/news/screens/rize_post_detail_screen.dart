import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../data/mock_rize_replies.dart';
import '../widgets/rize_reply_card.dart';
import '../../comment/screens/comments_screen.dart';

class RizePostDetailScreen extends StatelessWidget {
  final RizePostModel post;
  const RizePostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildOriginalPost(context),
                  const Divider(color: NewsColors.divider),
                  ...mockReplies.map((reply) => RizeReplyCard(reply: reply)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            'Post',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CommentsScreen(
                    contextId: post.id,
                    contextName: post.username,
                    accent: NewsColors.accent,
                    contextType: CommentContextType.post,
                  ),
                ),
              );
            },
            child: const Icon(Icons.chat_bubble_outline, color: NewsColors.accent),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginalPost(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: NewsColors.accent.withOpacity(0.1),
                child: Text(
                  post.userName[0].toUpperCase(),
                  style: const TextStyle(color: NewsColors.accent, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName,
                    style: const TextStyle(
                      color: NewsColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    post.username,
                    style: const TextStyle(
                      color: NewsColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            post.text,
            style: const TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          if (post.mediaUrls.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                post.mediaUrls[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: NewsColors.surface,
                  child: const Icon(Icons.broken_image, color: NewsColors.textSecondary),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.favorite_border, color: NewsColors.textSecondary, size: 18),
              const SizedBox(width: 4),
              Text('${post.likes}', style: const TextStyle(color: NewsColors.textSecondary, fontSize: 13)),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CommentsScreen(
                        contextId: post.id,
                        contextName: post.username,
                        accent: NewsColors.accent,
                        contextType: CommentContextType.post,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline, color: NewsColors.textSecondary, size: 18),
                    const SizedBox(width: 4),
                    Text('${post.comments}', style: const TextStyle(color: NewsColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.repeat, color: NewsColors.repost, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
