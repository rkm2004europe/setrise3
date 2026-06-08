import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../user/screens/user_preview_sheet.dart';

class RizeUserTile extends StatelessWidget {
  final String userId;
  final String userName;
  final String username;
  final String? avatarUrl;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const RizeUserTile({
    super.key,
    required this.userId,
    required this.userName,
    required this.username,
    this.avatarUrl,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => showUserPreviewSheet(context, userId: userId, userName: userName, username: username, accent: NewsColors.accent),
        child: CircleAvatar(
          backgroundColor: NewsColors.accent.withOpacity(0.1),
          child: Text(userName[0].toUpperCase(), style: const TextStyle(color: NewsColors.accent)),
        ),
      ),
      title: Text(userName, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w600)),
      subtitle: Text(username, style: const TextStyle(color: NewsColors.textSecondary)),
      trailing: GestureDetector(
        onTap: onFollowToggle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isFollowing ? NewsColors.surface : NewsColors.accent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isFollowing ? NewsColors.border : NewsColors.accent),
          ),
          child: Text(isFollowing ? 'Following' : 'Follow',
              style: TextStyle(color: isFollowing ? NewsColors.textPrimary : Colors.white, fontSize: 12)),
        ),
      ),
    );
  }
}
