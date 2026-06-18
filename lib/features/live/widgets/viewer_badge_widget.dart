import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ViewerBadgeWidget extends StatelessWidget {
  final String badgeName;
  final Color color;
  final bool isEarned;

  const ViewerBadgeWidget({super.key, required this.badgeName, required this.color, this.isEarned = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isEarned ? color.withOpacity(0.2) : LiveColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isEarned ? color : LiveColors.border),
      ),
      child: Text(badgeName, style: TextStyle(color: isEarned ? color : LiveColors.text2, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
