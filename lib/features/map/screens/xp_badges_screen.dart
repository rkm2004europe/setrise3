import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class XpBadgesScreen extends StatelessWidget {
  const XpBadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            const Text('المستوى 5', style: TextStyle(color: MapColors.text, fontSize: 28, fontWeight: FontWeight.w900)),
            const Text('1250 / 2500 XP', style: TextStyle(color: MapColors.text2)),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: 0.5, color: MapColors.accent, backgroundColor: MapColors.surface),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                children: ['🌟 مستكشف', '🔥 ناشط', '💬 متواصل', '📍 مغامر', '🎯 هادف', '🏆 بطل'].map((b) => Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: MapColors.surface, borderRadius: BorderRadius.circular(14)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(b, style: const TextStyle(fontSize: 12, color: MapColors.text)),
                  ]),
                )).toList(),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MapColors.text)),
      const SizedBox(width: 12),
      const Text('الشارات والخبرة', style: TextStyle(color: MapColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
