import 'package:flutter/material.dart';
import '../theme/colors.dart';

class EncryptionBadge extends StatelessWidget {
  const EncryptionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: ChatColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, color: ChatColors.accent, size: 14),
          SizedBox(width: 4),
          Text('مشفرة', style: TextStyle(color: ChatColors.accent, fontSize: 11)),
        ],
      ),
    );
  }
}
