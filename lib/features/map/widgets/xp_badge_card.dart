import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class XpBadgeCard extends StatelessWidget {
  final String badgeName;
  final bool earned;
  const XpBadgeCard({super.key, required this.badgeName, required this.earned});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: earned ? MapColors.accent.withOpacity(0.1) : MapColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: earned ? MapColors.accent : MapColors.border),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(earned ? Icons.star : Icons.lock, color: earned ? MapColors.gold : MapColors.text2),
        const SizedBox(height: 4),
        Text(badgeName, style: TextStyle(color: earned ? MapColors.text : MapColors.text2, fontSize: 10)),
      ]),
    );
  }
}
