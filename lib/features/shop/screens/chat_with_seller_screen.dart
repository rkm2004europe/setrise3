import 'package:flutter/material.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart' as chat;

class ChatWithSellerScreen extends StatelessWidget {
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;

  const ChatWithSellerScreen({
    super.key,
    required this.sellerId,
    required this.sellerName,
    required this.sellerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    // بناء محادثة جديدة مع البائع
    final conv = chat.Conversation(
      id: 'shop_$sellerId',
      user: chat.User(id: sellerId, name: sellerName, username: '@$sellerName', avatar: sellerAvatar, type: chat.ConvType.friend),
      type: chat.ConvType.friend,
      lastMessage: null,
      unread: 0,
      isArchived: false,
      isMuted: false,
      updatedAt: DateTime.now(),
    );
    return ChatScreen(conversation: conv);
  }
}
