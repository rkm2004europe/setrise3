import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BattleScoreAnim extends StatelessWidget {
  final int score1, score2;
  const BattleScoreAnim({super.key, required this.score1, required this.score2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$score1', style: const TextStyle(color: LiveColors.accent, fontSize: 32, fontWeight: FontWeight.w900)),
        const Text('VS', style: TextStyle(color: LiveColors.text2, fontSize: 20)),
        Text('$score2', style: const TextStyle(color: LiveColors.gold, fontSize: 32, fontWeight: FontWeight.w900)),
      ],
    );
  }
}
