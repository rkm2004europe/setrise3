import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/battle_model.dart';
import '../data/mock_battles.dart';

class LiveBattleScreen extends StatefulWidget {
  const LiveBattleScreen({super.key});

  @override
  State<LiveBattleScreen> createState() => _LiveBattleScreenState();
}

class _LiveBattleScreenState extends State<LiveBattleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              const Text('المعارك المباشرة', style: TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: mockBattles.length,
                  itemBuilder: (_, i) {
                    final battle = mockBattles[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: LiveColors.border)),
                      child: Column(
                        children: [
                          Text('معركة ${battle.id}', style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            _buildHostScore(battle.host1Id, battle.host1Score),
                            const Text('VS', style: TextStyle(color: LiveColors.accent, fontWeight: FontWeight.w900)),
                            _buildHostScore(battle.host2Id, battle.host2Score),
                          ]),
                          const SizedBox(height: 10),
                          if (battle.isActive)
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                                child: const Center(child: Text('انضم للمشاهدة', style: TextStyle(color: Colors.white))),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHostScore(String hostId, int score) => Column(
    children: [
      CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: const Icon(Icons.person, color: LiveColors.accent)),
      const SizedBox(height: 6),
      Text('$score نقطة', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w700)),
    ],
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
  ]);
}
