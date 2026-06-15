import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/serendipity_model.dart';

class SerendipitySheet extends StatelessWidget {
  final SerendipityModel match;
  const SerendipitySheet({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MapColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Text('لقاء المصادفة ✨', style: TextStyle(color: MapColors.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 12),
          CircleAvatar(radius: 35, backgroundColor: MapColors.accent.withOpacity(0.1), child: Text(match.avatar, style: const TextStyle(fontSize: 32))),
          const SizedBox(height: 8),
          Text(match.userName, style: const TextStyle(color: MapColors.text, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('توافق ${match.compatibilityScore}%', style: const TextStyle(color: MapColors.accent)),
          const SizedBox(height: 10),
          Wrap(spacing: 6, children: match.sharedInterests.map((i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: MapColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Text(i, style: const TextStyle(color: MapColors.accent, fontSize: 12)),
          )).toList()),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: MapColors.accent, borderRadius: BorderRadius.circular(14)),
              child: const Center(child: Text('إرسال رسالة', style: TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}
