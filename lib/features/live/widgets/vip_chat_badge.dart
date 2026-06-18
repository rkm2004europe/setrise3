import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/vip_system_model.dart';

class VipChatBadge extends StatelessWidget {
  final String vipLevel;
  const VipChatBadge({super.key, required this.vipLevel});

  @override
  Widget build(BuildContext context) {
    final level = vipLevels.firstWhere((l) => l.name == vipLevel, orElse: () => vipLevels.first);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: level.badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: level.badgeColor.withOpacity(0.5)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(level.badgeIcon, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 2),
        Text(level.name, style: TextStyle(color: level.badgeColor, fontSize: 9, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
