import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StreamDetailsAnalyticsScreen extends StatelessWidget {
  const StreamDetailsAnalyticsScreen({super.key});

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
              _stat('أعلى مشاهدة متزامنة', '230'),
              _stat('متوسط وقت المشاهدة', '12 دقيقة'),
              _stat('الهدايا', '45 🪙'),
              _stat('التفاعلات', '89'),
              _stat('المشاركات', '12'),
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
          const Text('تفاصيل البث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
