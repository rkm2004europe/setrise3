import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveRankingScreen extends StatelessWidget {
  const LiveRankingScreen({super.key});

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
                itemCount: 20,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: i < 3 ? LiveColors.gold.withOpacity(0.1) : LiveColors.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(children: [
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text('${i+1}', style: TextStyle(
                        color: i < 3 ? LiveColors.gold : LiveColors.text2,
                        fontWeight: FontWeight.w900,
                      )),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1)),
                    const SizedBox(width: 12),
                    Expanded(child: Text('مستخدم ${i+1}', style: const TextStyle(color: LiveColors.text))),
                    Text('${(20-i)*150} 🪙', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w600)),
                  ]),
                ),
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
      const Text('التصنيف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
