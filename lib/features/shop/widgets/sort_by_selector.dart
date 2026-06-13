import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SortBySelector extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const SortBySelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          dropdownColor: ShopColors.surface,
          style: const TextStyle(color: ShopColors.text, fontSize: 14),
          items: const [
            DropdownMenuItem(value: 'latest', child: Text('الأحدث')),
            DropdownMenuItem(value: 'price_low', child: Text('السعر: منخفض لمرتفع')),
            DropdownMenuItem(value: 'price_high', child: Text('السعر: مرتفع لمنخفض')),
            DropdownMenuItem(value: 'rating', child: Text('التقييم')),
          ],
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}
