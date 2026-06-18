import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SoundEffectsLibrary extends StatelessWidget {
  final Function(String emoji) onPlay;
  const SoundEffectsLibrary({super.key, required this.onPlay});

  final List<Map<String, String>> sounds = const [
    {'emoji': '😂', 'name': 'ضحك'},
    {'emoji': '👏', 'name': 'تصفيق'},
    {'emoji': '🎉', 'name': 'احتفال'},
    {'emoji': '😱', 'name': 'مفاجأة'},
    {'emoji': '💥', 'name': 'انفجار'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.9), borderRadius: BorderRadius.circular(16)),
      child: Wrap(
        spacing: 12, runSpacing: 12,
        children: sounds.map((s) => GestureDetector(
          onTap: () => onPlay(s['emoji']!),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(s['emoji']!, style: const TextStyle(fontSize: 24)))),
            const SizedBox(height: 4),
            Text(s['name']!, style: const TextStyle(color: LiveColors.text2, fontSize: 10)),
          ]),
        )).toList(),
      ),
    );
  }
}
