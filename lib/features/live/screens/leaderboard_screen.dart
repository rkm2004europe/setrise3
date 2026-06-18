import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_leaderboard.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
                itemCount: mockLeaderboard.length,
                itemBuilder: (_, i) {
                  final entry = mockLeaderboard[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text('${i+1}')),
                    title: Text(entry.userName, style: const TextStyle(color: LiveColors.text)),
                    trailing: Text('${entry.coins} 🪙', style: const TextStyle(color: LiveColors.gold)),
                  );
                },
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
      const Text('المتصدرون', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
