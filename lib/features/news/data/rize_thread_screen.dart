import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../data/mock_rize_replies.dart';
import '../widgets/rize_reply_card.dart';
import '../models/rize_reply_model.dart';

class RizeThreadScreen extends StatelessWidget {
  final RizePostModel post;
  const RizeThreadScreen({super.key, required this.post});

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
                  // المنشور الأصلي
                  _buildOriginalPost(),
                  const Divider(color: NewsColors.divider),
                  // الردود
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
            child: const Icon(Icons.close, color: NewsColors.textPrimary),
          ),
          const SizedBox(width: 12),
          const Text(
            'Thread',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginalPost() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: NewsColors.accent.withOpacity(0.1),
                child: Text(post.userName[0],
                    style: const TextStyle(color: NewsColors.accent)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.userName,
                      style: const TextStyle(
                          color: NewsColors.textPrimary,
                          fontWeight: FontWeight.w700)),
                  Text(post.username,
                      style: const TextStyle(
                          color: NewsColors.textSecondary, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(post.text,
              style: const TextStyle(
                  color: NewsColors.textPrimary,
                  fontSize: 16,
                  height: 1.4)),
        ],
      ),
    );
  }
}
