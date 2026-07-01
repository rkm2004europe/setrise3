import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MoodSelector extends StatelessWidget {
  final Function(String) onMoodSelected;
  const MoodSelector({super.key, required this.onMoodSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Wrap(spacing: 8, children: ['😊', '😢', '🔥', '🧘', '💪', '🌙'].map((e) => GestureDetector(
        onTap: () => onMoodSelected(e),
        child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(12)), child: Text(e, style: const TextStyle(fontSize: 24))),
      )).toList()),
    );
  }
}
