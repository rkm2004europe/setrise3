import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/vip_tier_model.dart';

class VipBadge extends StatelessWidget {
  final VipTier tier;
  const VipBadge({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    if (tier == VipTier.normal) return const SizedBox.shrink();
    IconData icon;
    Color color;
    switch (tier) {
      case VipTier.vip:
        icon = Icons.star;
        color = LiveColors.gold;
        break;
      case VipTier.gold:
        icon = Icons.workspace_premium;
        color = LiveColors.gold;
        break;
      case VipTier.diamond:
        icon = Icons.diamond;
        color = LiveColors.diamond;
        break;
      case VipTier.moderator:
        icon = Icons.shield;
        color = LiveColors.accent;
        break;
      case VipTier.host:
        icon = Icons.mic;
        color = LiveColors.accent;
        break;
      default:
        return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(left: 4),
      child: Icon(icon, color: color, size: 14),
    );
  }
}
