import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MusicSelector extends StatelessWidget {
  const MusicSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('موسيقى', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _track('🎵', 'هادي'),
          _track('🎸', 'روك'),
          _track('🎹', 'كلاسيك'),
        ]),
      ]),
    );
  }

  Widget _track(String emoji, String label) => GestureDetector(
    onTap: () {},
    child: Column(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22)))),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: LiveColors.text2, fontSize: 10)),
    ]),
  );
}
