import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FilterChips extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final Function(String) onChanged;

  const FilterChips({super.key, required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: options.map((o) => GestureDetector(
        onTap: () => onChanged(o),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected == o ? ShopColors.accent : ShopColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected == o ? ShopColors.accent : ShopColors.border),
          ),
          child: Text(o, style: TextStyle(color: selected == o ? Colors.white : ShopColors.text, fontSize: 12)),
        ),
      )).toList(),
    );
  }
}
