import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveUserCard extends StatelessWidget {
  final String userId;
  final String userName;
  final String avatar;
  final String vipLevel;
  final int level;

  const LiveUserCard({
    super.key,
    required this.userId,
    required this.userName,
    required this.avatar,
    this.vipLevel = '',
    this.level = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showUserPreviewSheet(context, userId: userId, userName: userName, username: '@$userName', accent: LiveColors.accent),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(avatar)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(userName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700)),
            Text('Lv.$level', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
          ])),
          if (vipLevel.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: LiveColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: Text(vipLevel, style: const TextStyle(color: LiveColors.gold, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
        ]),
      ),
    );
  }
}
