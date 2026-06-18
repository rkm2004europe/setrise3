import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MonthlySummaryScreen extends StatelessWidget {
  const MonthlySummaryScreen({super.key});

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
              _stat('بثوث', '12'),
              _stat('مشاهدات', '5.4K'),
              _stat('هدايا', '120 🪙'),
              _stat('أرباح', '\$34.50'),
              _stat('متابعين جدد', '45'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Text(label, style: const TextStyle(color: LiveColors.text2)),
            const Spacer(),
            Text(value, style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w800)),
          ],
        ),
      );

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('الملخص الشهري', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
