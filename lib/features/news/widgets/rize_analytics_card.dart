import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeAnalyticsCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const RizeAnalyticsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NewsColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: NewsColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(_formatNumber(value), style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w900, fontSize: 18)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
