import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/vip_system_model.dart';

class VipStatusCard extends StatelessWidget {
  final String currentLevel;
  final int currentCoins;
  final int coinsToNextLevel;
  final VoidCallback onUpgrade;

  const VipStatusCard({
    super.key,
    required this.currentLevel,
    required this.currentCoins,
    required this.coinsToNextLevel,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final level = vipLevels.firstWhere((l) => l.name == currentLevel);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [level.badgeColor.withOpacity(0.3), LiveColors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: level.badgeColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(level.badgeIcon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentLevel, style: TextStyle(color: level.badgeColor, fontWeight: FontWeight.w800, fontSize: 18)),
                    Text('$currentCoins 🪙', style: const TextStyle(color: LiveColors.text2)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: level.badgeColor, borderRadius: BorderRadius.circular(12)),
                child: const Text('حالي', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (coinsToNextLevel > 0) ...[
            LinearProgressIndicator(
              value: currentCoins / (currentCoins + coinsToNextLevel),
              color: level.badgeColor,
              backgroundColor: LiveColors.text2.withOpacity(0.2),
            ),
            const SizedBox(height: 6),
            Text('متبقي $coinsToNextLevel 🪙 للمستوى التالي', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
          ],
          const SizedBox(height: 12),
          // المزايا
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: level.perks.map((perk) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(10)),
              child: Text(perk, style: const TextStyle(color: LiveColors.text, fontSize: 11)),
            )).toList(),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onUpgrade,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: level.badgeColor, borderRadius: BorderRadius.circular(12)),
              child: const Center(child: Text('ترقية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
            ),
          ),
        ],
      ),
    );
  }
}
