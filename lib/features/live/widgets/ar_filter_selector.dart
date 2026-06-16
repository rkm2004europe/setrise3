import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/ar_filter_model.dart';
import '../data/mock_ar_filters.dart';

class ArFilterSelector extends StatelessWidget {
  final Function(ArFilterModel) onSelected;

  const ArFilterSelector({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('فلاتر AR', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: mockArFilters.map((filter) => GestureDetector(
          onTap: () => onSelected(filter),
          child: Column(children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(color: filter.isPremium ? LiveColors.gold.withOpacity(0.2) : LiveColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: filter.isPremium ? LiveColors.gold : LiveColors.border)), child: Center(child: Text(filter.thumbnailEmoji, style: const TextStyle(fontSize: 24)))),
            const SizedBox(height: 4),
            Text(filter.name, style: const TextStyle(color: LiveColors.text, fontSize: 10)),
            if (filter.isPremium) const Icon(Icons.lock, color: LiveColors.gold, size: 10),
          ]),
        )).toList()),
      ]),
    );
  }
}
