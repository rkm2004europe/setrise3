import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_notification_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class RizeNotificationTile extends StatelessWidget {
  final RizeNotificationModel notification;
  final VoidCallback onTap;

  const RizeNotificationTile({super.key, required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => showUserPreviewSheet(context, userId: notification.actorUserId, userName: notification.actorUserName, username: '', accent: NewsColors.accent),
        child: CircleAvatar(
          backgroundColor: notification.isRead ? NewsColors.surface : NewsColors.accent.withOpacity(0.1),
          child: Icon(_getIcon(), color: notification.isRead ? NewsColors.textSecondary : NewsColors.accent),
        ),
      ),
      title: Text(_getMessage(), style: TextStyle(color: notification.isRead ? NewsColors.textSecondary : NewsColors.textPrimary, fontWeight: FontWeight.w600)),
      subtitle: notification.preview != null ? Text(notification.preview!, style: const TextStyle(color: NewsColors.textSecondary)) : null,
      onTap: onTap,
    );
  }

  IconData _getIcon() {
    switch (notification.type) {
      case RizeNotificationType.like: return Icons.favorite;
      case RizeNotificationType.reply: return Icons.chat_bubble;
      case RizeNotificationType.repost: return Icons.repeat;
      case RizeNotificationType.follow: return Icons.person_add;
      case RizeNotificationType.mention: return Icons.alternate_email;
    }
  }

  String _getMessage() {
    switch (notification.type) {
      case RizeNotificationType.like: return '${notification.actorUserName} liked your Rize';
      case RizeNotificationType.reply: return '${notification.actorUserName} replied to your Rize';
      case RizeNotificationType.repost: return '${notification.actorUserName} reposted your Rize';
      case RizeNotificationType.follow: return '${notification.actorUserName} followed you';
      case RizeNotificationType.mention: return '${notification.actorUserName} mentioned you';
    }
  }
}
