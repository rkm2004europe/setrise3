import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DailyRewardsScreen extends StatefulWidget {
  const DailyRewardsScreen({super.key});

  @override
  State<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends State<DailyRewardsScreen> {
  int _day = 3;

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
              Text('اليوم $_day', style: const TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('مكافأة اليوم: 50 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 20)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(7, (i) => Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: i < _day ? LiveColors.gold : LiveColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('${i+1}', style: TextStyle(color: i < _day ? Colors.black : LiveColors.text2))),
              ))),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('استلام المكافأة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('المكافآت اليومية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
