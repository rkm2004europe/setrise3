import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DailyMixCard extends StatelessWidget {
  final String title;
  final String emoji;
  final int trackCount;
  final VoidCallback onTap;

  const DailyMixCard({super.key, required this.title, required this.emoji, required this.trackCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160, margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Text(emoji, style: const TextStyle(fontSize: 48))),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w700)),
          Text('$trackCount أغنية', style: const TextStyle(color: MusicColors.text2, fontSize: 12)),
        ]),
      ),
    );
  }
}
