import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/viewer_level_icon.dart';
import '../widgets/viewer_badge_widget.dart';
import 'gift_history_screen.dart';
import 'live_history_screen.dart';
import 'monthly_summary_screen.dart';

class LiveProfileScreen extends StatelessWidget {
  const LiveProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 16),
              // معلومات المستخدم
              const CircleAvatar(radius: 40, backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text('🧑', style: TextStyle(fontSize: 36))),
              const SizedBox(height: 10),
              const Text('Ahmed', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
              const Text('@ahmed_k', style: TextStyle(color: LiveColors.text2)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const ViewerLevelIcon(level: 5),
                const SizedBox(width: 12),
                ViewerBadgeWidget(badgeName: 'VIP', color: LiveColors.gold, isEarned: true),
              ]),
              const SizedBox(height: 12),
              // إحصائيات
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _stat('المشاهدات', '12.4K'),
                _stat('الهدايا', '340 🪙'),
                _stat('المستوى', '5'),
              ]),
              const SizedBox(height: 20),
              // قائمة الميزات
              _menuItem(Icons.history, 'سجل البثوث', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveHistoryScreen()))),
              _menuItem(Icons.card_giftcard, 'سجل الهدايا', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftHistoryScreen()))),
              _menuItem(Icons.summarize, 'الملخص الشهري', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlySummaryScreen()))),
              _menuItem(Icons.star, 'الشارات', () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) => Column(children: [
        Text(value, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w900, fontSize: 18)),
        Text(label, style: const TextStyle(color: LiveColors.text2, fontSize: 11)),
      ]);

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) => ListTile(
        leading: Icon(icon, color: LiveColors.text),
        title: Text(title, style: const TextStyle(color: LiveColors.text)),
        trailing: const Icon(Icons.chevron_right, color: LiveColors.text2),
        onTap: onTap,
      );

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('ملفي في Live', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
