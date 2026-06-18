import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_daily_quests.dart';
import '../widgets/daily_quest_card.dart';

class DailyQuestsScreen extends StatelessWidget {
  const DailyQuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockDailyQuests.length,
                itemBuilder: (_, i) => DailyQuestCard(quest: mockDailyQuests[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('المهمات اليومية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
