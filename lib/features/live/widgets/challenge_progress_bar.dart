import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChallengeProgressBar extends StatelessWidget {
  final int current, total;
  const ChallengeProgressBar({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: LinearProgressIndicator(value: total > 0 ? current / total : 0, color: LiveColors.accent, backgroundColor: LiveColors.text2.withOpacity(0.2))),
      const SizedBox(width: 8),
      Text('$current/$total', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
    ]);
  }
}
