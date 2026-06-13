import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DatePreferencesChips extends StatelessWidget {
  final List<String> interests;
  final List<String> selected;
  final Function(String) onToggle;

  const DatePreferencesChips({super.key, required this.interests, required this.selected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: interests.map((i) {
        final sel = selected.contains(i);
        return GestureDetector(
          onTap: () => onToggle(i),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: sel ? DateColors.accent : DateColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: sel ? DateColors.accent : DateColors.border),
            ),
            child: Text(i, style: TextStyle(color: sel ? Colors.white : DateColors.text, fontSize: 12)),
          ),
        );
      }).toList(),
    );
  }
}
