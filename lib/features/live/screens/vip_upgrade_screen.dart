import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/vip_system_model.dart';

class VipUpgradeScreen extends StatelessWidget {
  const VipUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: vipLevels.map((level) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LiveColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: level.badgeColor.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(level.badgeIcon, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 10),
                        Text(level.name, style: TextStyle(color: level.badgeColor, fontWeight: FontWeight.w800, fontSize: 18)),
                      ]),
                      const SizedBox(height: 8),
                      Text('${level.requiredCoins} 🪙', style: const TextStyle(color: LiveColors.gold)),
                      const SizedBox(height: 10),
                      ...level.perks.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(children: [
                          const Icon(Icons.check, color: LiveColors.green, size: 14),
                          const SizedBox(width: 6),
                          Text(p, style: const TextStyle(color: LiveColors.text, fontSize: 13)),
                        ]),
                      )),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: level.badgeColor, borderRadius: BorderRadius.circular(12)),
                          child: const Center(child: Text('ترقية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
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
      const Text('ترقية VIP', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
