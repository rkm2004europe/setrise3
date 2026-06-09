import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_analytics.dart';
import '../widgets/rize_analytics_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
                  const Text('Analytics', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      RizeAnalyticsCard(label: 'Likes', value: mockAnalytics.totalLikes, icon: Icons.favorite, color: NewsColors.likeActive),
                      RizeAnalyticsCard(label: 'Comments', value: mockAnalytics.totalComments, icon: Icons.chat_bubble, color: NewsColors.accent),
                      RizeAnalyticsCard(label: 'Shares', value: mockAnalytics.totalShares, icon: Icons.repeat, color: NewsColors.repost),
                      RizeAnalyticsCard(label: 'Profile Views', value: mockAnalytics.profileViews, icon: Icons.visibility, color: NewsColors.saveActive),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Daily Likes (Last 7 Days)', style: TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: mockAnalytics.dailyLikes.map((likes) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: (likes / 120) * 120,
                            decoration: BoxDecoration(
                              color: NewsColors.accent.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        );
                      }).toList(),
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
}
