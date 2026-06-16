import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/moderator_tools.dart';

class HostDashboardScreen extends StatelessWidget {
  const HostDashboardScreen({super.key});

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
              _buildStat('المشاهدون', '120', LiveColors.text),
              _buildStat('الهدايا', '340 🪙', LiveColors.gold),
              const SizedBox(height: 20),
              const ModeratorTools(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) => Container(
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Text(label, style: const TextStyle(color: LiveColors.text2)),
      const Spacer(),
      Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('لوحة المضيف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
