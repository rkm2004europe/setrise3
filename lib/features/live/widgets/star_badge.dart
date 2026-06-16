import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StarBadge extends StatelessWidget {
  final int level;
  const StarBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: LiveColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.star, color: LiveColors.gold, size: 14),
        const SizedBox(width: 4),
        Text('$level', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
