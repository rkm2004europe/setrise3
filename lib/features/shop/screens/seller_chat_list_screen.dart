import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart' as chat;

class SellerChatListScreen extends StatelessWidget {
  const SellerChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      chat.Conversation(
        id: 'sc1', user: chat.User(id: 'u1', name: 'مشتري 1', username: '@buyer1', avatar: '🧑', type: chat.ConvType.friend),
        type: chat.ConvType.friend, lastMessage: null, unread: 1, isArchived: false, isMuted: false, updatedAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(backgroundColor: ShopColors.accent.withOpacity(0.1), child: Text(conversations[i].user.avatar)),
                  title: Text(conversations[i].user.name, style: const TextStyle(color: ShopColors.text)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(conversation: conversations[i]))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('المراسلات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
