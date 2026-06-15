import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart' as chat;

class OrderIssueChat extends StatelessWidget {
  const OrderIssueChat({super.key});

  @override
  Widget build(BuildContext context) {
    final conv = chat.Conversation(
      id: 'support',
      user: chat.User(id: 'support', name: 'دعم SetRise', username: '@support', avatar: '🛟', type: chat.ConvType.friend),
      type: chat.ConvType.friend,
      lastMessage: null, unread: 0, isArchived: false, isMuted: false, updatedAt: DateTime.now(),
    );
    return ChatScreen(conversation: conv);
  }
}
