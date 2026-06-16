import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_viewers.dart';

class ViewerListSheet extends StatelessWidget {
  const ViewerListSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: LiveColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Text('المشاهدون', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...mockViewers.map((v) => ListTile(
            leading: CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(v.avatar)),
            title: Text(v.userName, style: const TextStyle(color: LiveColors.text)),
            trailing: v.isModerator ? const Icon(Icons.shield, color: LiveColors.gold, size: 16) : v.isVip ? const Icon(Icons.star, color: LiveColors.gold, size: 16) : null,
          )),
        ],
      ),
    );
  }
}
