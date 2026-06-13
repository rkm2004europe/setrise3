import '../models/models.dart';

final User u1 = const User(id: 'u1', name: 'Ahmed K.', username: '@ahmed_k', avatar: '🧑', isOnline: true);
final User u2 = const User(id: 'u2', name: 'Sara M.', username: '@sara_m', avatar: '👩');
final User u3 = const User(id: 'u3', name: 'Omar T.', username: '@omar_t', avatar: '👨', isOnline: true);
final User u4 = const User(id: 'u4', name: 'Lina R.', username: '@lina_r', avatar: '👩‍💻');

List<Conversation> mockConversations() => [
  Conversation(
    id: 'c1', user: u1, type: ConvType.friend,
    lastMessage: Message(id: 'm1', senderId: 'u1', type: MsgType.text, text: 'رائع! متى الإطلاق؟', status: MsgStatus.read, createdAt: DateTime.now().subtract(const Duration(minutes: 5))),
    unread: 2, updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  Conversation(
    id: 'c2', user: u2, type: ConvType.friend,
    lastMessage: Message(id: 'm2', senderId: 'me', type: MsgType.image, mediaEmoji: '🖼️', status: MsgStatus.delivered, createdAt: DateTime.now().subtract(const Duration(hours: 1))),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  Conversation(
    id: 'c3', type: ConvType.group, groupName: 'Flutter Devs', groupAvatar: '👥', membersCount: 120,
    user: u3, lastMessage: Message(id: 'm3', senderId: 'u3', type: MsgType.text, text: 'لقاء السبت القادم', status: MsgStatus.read, createdAt: DateTime.now().subtract(const Duration(hours: 3))),
    unread: 5, updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Conversation(
    id: 'c4', type: ConvType.channel, groupName: 'SetRise Updates', groupAvatar: '📢', membersCount: 5000,
    user: u4, lastMessage: Message(id: 'm4', senderId: 'u4', type: MsgType.text, text: 'تحديث جديد متاح!', status: MsgStatus.read, createdAt: DateTime.now().subtract(const Duration(days: 1))),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
