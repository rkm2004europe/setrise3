import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/giveaway_model.dart';
import '../data/mock_giveaways.dart';

class GiveawayScreen extends StatelessWidget {
  const GiveawayScreen({super.key});

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
              Expanded(
                child: ListView(
                  children: mockGiveaways.map((gw) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: LiveColors.gold.withOpacity(0.3))),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('🎉 ${gw.prize}', style: const TextStyle(color: LiveColors.gold, fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('الفائزون: ${gw.winnersCount}', style: const TextStyle(color: LiveColors.text)),
                      Text('المشاركون: ${gw.participants.length}', style: const TextStyle(color: LiveColors.text2)),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: LiveColors.gold, borderRadius: BorderRadius.circular(14)),
                          child: const Center(child: Text('شارك الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800))),
                        ),
                      ),
                    ]),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('السحوبات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
