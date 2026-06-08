import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_notifications.dart';
import '../widgets/rize_notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: NewsColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: NewsColors.divider),
            Expanded(
              child: ListView.builder(
                itemCount: mockNotifications.length,
                itemBuilder: (context, index) {
                  return RizeNotificationTile(
                    notification: mockNotifications[index],
                    onTap: () {
                      // الانتقال إلى المنشور المناسب
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
