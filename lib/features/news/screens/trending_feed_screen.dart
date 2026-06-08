import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/trending_topics.dart';
import '../data/mock_rize_posts.dart';
import '../widgets/rize_post_card.dart';
import '../models/rize_post_model.dart';

class TrendingFeedScreen extends StatefulWidget {
  const TrendingFeedScreen({super.key});

  @override
  State<TrendingFeedScreen> createState() => _TrendingFeedScreenState();
}

class _TrendingFeedScreenState extends State<TrendingFeedScreen> {
  late List<RizePostModel> _posts;

  @override
  void initState() {
    super.initState();
    _posts = generateMockRizePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView(
                children: [
                  _buildTrendingTopics(),
                  const Divider(color: NewsColors.divider),
                  ..._posts.map((post) => RizePostCard(
                        post: post,
                        onUpdate: (updated) {
                          setState(() {
                            final index = _posts.indexWhere((p) => p.id == updated.id);
                            if (index != -1) _posts[index] = updated;
                          });
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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
            'Trending',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Topics',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ...trendingTopics.map((topic) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
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
                          Text(
                            topic.title,
                            style: const TextStyle(
                              color: NewsColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_formatNumber(topic.postsCount)} posts',
                            style: const TextStyle(
                              color: NewsColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
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
                        child: Text(
                          topic.hashtag!,
                          style: const TextStyle(color: NewsColors.accent, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
