import '../models/rize_notification_model.dart';

List<RizeNotificationModel> mockNotifications = [
  RizeNotificationModel(
    id: 'n1',
    type: RizeNotificationType.like,
    actorUserId: 'u2',
    actorUserName: 'Sara M.',
    preview: 'أفضل طريقة لتعلم البرمجة...',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  RizeNotificationModel(
    id: 'n2',
    type: RizeNotificationType.reply,
    actorUserId: 'u3',
    actorUserName: 'Omar T.',
    preview: 'أوافقك الرأي تمامًا!',
    createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  RizeNotificationModel(
    id: 'n3',
    type: RizeNotificationType.follow,
    actorUserId: 'u4',
    actorUserName: 'Lina R.',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  RizeNotificationModel(
    id: 'n4',
    type: RizeNotificationType.repost,
    actorUserId: 'u5',
    actorUserName: 'Nora X.',
    preview: 'تحديث رائع!',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];
