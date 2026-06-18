import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveCategoryChips extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;

  const LiveCategoryChips({super.key, required this.selectedCategory, required this.onCategoryChanged});

  static const categories = ['الكل', 'ترفيه', 'ألعاب', 'موسيقى', 'فن', 'تحديات', 'رياضة', 'طبخ'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = (selectedCategory ?? 'الكل') == cat;
          return GestureDetector(
            onTap: () => onCategoryChanged(cat == 'الكل' ? null : cat),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? LiveColors.accent : LiveColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(cat, style: TextStyle(color: isSelected ? Colors.white : LiveColors.text2, fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          );
        },
      ),
    );
  }
}
