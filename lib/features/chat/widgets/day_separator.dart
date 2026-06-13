import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DaySeparator extends StatelessWidget {
  final DateTime date;
  const DaySeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Text(
          '${date.day}/${date.month}/${date.year}',
          style: const TextStyle(color: ChatColors.text2, fontSize: 12),
        ),
      ),
    );
  }
}
