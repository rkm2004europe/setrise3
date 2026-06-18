import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/viewer_badge_widget.dart';

class ViewerBadgeCollectionScreen extends StatelessWidget {
  const ViewerBadgeCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                children: [
                  ViewerBadgeWidget(badgeName: 'VIP', color: LiveColors.gold, isEarned: true),
                  ViewerBadgeWidget(badgeName: 'Gold', color: LiveColors.gold, isEarned: true),
                  ViewerBadgeWidget(badgeName: 'Diamond', color: LiveColors.diamond, isEarned: false),
                  ViewerBadgeWidget(badgeName: 'Moderator', color: LiveColors.accent, isEarned: true),
                  ViewerBadgeWidget(badgeName: 'Host', color: LiveColors.accent, isEarned: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('الشارات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
