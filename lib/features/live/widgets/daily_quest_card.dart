import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/daily_quest_model.dart';

class DailyQuestCard extends StatelessWidget {
  final DailyQuestModel quest;
  const DailyQuestCard({super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: quest.isCompleted ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: quest.isCompleted ? LiveColors.accent : LiveColors.border),
      ),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(quest.description, style: TextStyle(color: quest.isCompleted ? LiveColors.text2 : LiveColors.text, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: quest.target > 0 ? quest.progress / quest.target : 0, color: LiveColors.accent),
          ]),
        ),
        const SizedBox(width: 12),
        Text('+${quest.xpReward > 0 ? '${quest.xpReward} XP' : '${quest.coinReward} 🪙'}', style: const TextStyle(color: LiveColors.gold)),
      ]),
    );
  }
}
