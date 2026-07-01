import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/category_model.dart';
import '../data/mock_categories.dart';

class CategoryChips extends StatelessWidget {
  final String? selected;
  final Function(String) onChanged;

  const CategoryChips({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: mockCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = mockCategories[i];
          final isSelected = selected == cat.name;
          return GestureDetector(
            onTap: () => onChanged(cat.name),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? MusicColors.accent : MusicColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: [
                Text(cat.emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(cat.name, style: TextStyle(color: isSelected ? Colors.white : MusicColors.text2, fontWeight: FontWeight.w600, fontSize: 12)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
