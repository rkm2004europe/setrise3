import '../models/rize_notification_model.dart';
import '../data/mock_rize_notifications.dart';

class RizeNotificationService {
  Future<List<RizeNotificationModel>> fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockNotifications;
  }

  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      mockNotifications[index] = RizeNotificationModel(
        id: id,
        type: mockNotifications[index].type,
        actorUserId: mockNotifications[index].actorUserId,
        actorUserName: mockNotifications[index].actorUserName,
        createdAt: mockNotifications[index].createdAt,
        isRead: true,
      );
    }
  }
}
