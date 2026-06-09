import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_rewind.dart';
import '../widgets/rize_post_card.dart';

class RewindScreen extends StatelessWidget {
  const RewindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Your Weekly Rewind', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [NewsColors.accent.withOpacity(0.2), NewsColors.surface]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 10),
                        Text('${mockRewind.totalLikes} likes this week',
                            style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w900, fontSize: 18)),
                        Text('${mockRewind.newFollowers} new followers',
                            style: const TextStyle(color: NewsColors.textSecondary, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Your Top Posts', style: TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                  ...mockRewind.topPosts.map((post) => RizePostCard(post: post, onUpdate: (_) {})),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
