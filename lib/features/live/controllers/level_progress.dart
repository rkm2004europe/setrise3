import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LevelProgress extends StatelessWidget {
  final int xp, xpToNext, level;
  const LevelProgress({super.key, required this.xp, required this.xpToNext, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('Lv.$level', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w700)),
        const SizedBox(width: 6),
        SizedBox(width: 60, child: LinearProgressIndicator(value: xp / xpToNext, color: LiveColors.gold, backgroundColor: LiveColors.text2.withOpacity(0.3))),
      ]),
    );
  }
}
