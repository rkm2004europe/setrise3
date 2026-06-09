import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'badges_screen.dart';
import 'analytics_screen.dart';
import 'monetization_screen.dart';

class CreatorDashboardScreen extends StatelessWidget {
  const CreatorDashboardScreen({super.key});

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
                  const Text('Creator Dashboard', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDashboardCard(context, 'Badges', Icons.verified, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BadgesScreen()));
                  }),
                  _buildDashboardCard(context, 'Analytics', Icons.bar_chart, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
                  }),
                  _buildDashboardCard(context, 'Monetization', Icons.attach_money, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MonetizationScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NewsColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: NewsColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: NewsColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: NewsColors.accent),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 16))),
            const Icon(Icons.chevron_right, color: NewsColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
