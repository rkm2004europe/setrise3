import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QuickFilterChips extends StatelessWidget {
  final Map<String, bool> filters;
  final Function(String, bool) onToggle;

  const QuickFilterChips({super.key, required this.filters, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _buildChip('الكل', filters.values.every((v) => v), () {
            filters.forEach((key, _) => onToggle(key, true));
          }),
          _buildChip('مطاعم', filters['restaurants'] ?? true, () {
            onToggle('restaurants', !(filters['restaurants'] ?? true));
          }),
          _buildChip('أحداث', filters['events'] ?? true, () {
            onToggle('events', !(filters['events'] ?? true));
          }),
          _buildChip('بث مباشر', filters['live'] ?? true, () {
            onToggle('live', !(filters['live'] ?? true));
          }),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool active, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: active ? MapColors.accent : MapColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: active ? MapColors.accent : MapColors.border),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : MapColors.text,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
}
