import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/viewer_level_icon.dart';
import '../widgets/viewer_badge_widget.dart';

class ViewerProgressScreen extends StatelessWidget {
  const ViewerProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              // المستوى الحالي
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [LiveColors.gold.withOpacity(0.2), LiveColors.surface]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  const ViewerLevelIcon(level: 5),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('المستوى 5', style: TextStyle(color: LiveColors.gold, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(value: 0.6, color: LiveColors.gold),
                    const SizedBox(height: 4),
                    const Text('600 / 1000 XP', style: TextStyle(color: LiveColors.text2, fontSize: 12)),
                  ])),
                ]),
              ),
              const SizedBox(height: 20),
              const Text('الشارات', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                ViewerBadgeWidget(badgeName: 'مراسل', color: LiveColors.gold, isEarned: true),
                ViewerBadgeWidget(badgeName: 'VIP', color: LiveColors.gold, isEarned: true),
                ViewerBadgeWidget(badgeName: 'مشجع', color: LiveColors.accent, isEarned: true),
                ViewerBadgeWidget(badgeName: 'أسطورة', color: LiveColors.diamond, isEarned: false),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('تقدمك', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
