import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../data/conversations.dart';
import '../widgets/tile.dart';
import '../widgets/app_bar.dart';
import 'chat.dart';
import 'archived.dart';
import 'new_chat.dart';
import 'search.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late List<Conversation> _conversations;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _conversations = mockConversations();
  }

  void _openChat(Conversation conv) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(conversation: conv)));
  }

  void _openArchived() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchivedScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final active = _conversations.where((c) => !c.isArchived).toList();

    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            ChatAppBar(
              title: 'Chats',
              actions: [
                IconButton(
                  icon: const Icon(Icons.archive_outlined, color: ChatColors.accent, size: 22),
                  onPressed: _openArchived,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: ChatColors.accent, size: 22),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewChatScreen())),
                ),
              ],
              onSearchTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchChatScreen())),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: active.length,
                itemBuilder: (context, index) => ConversationTile(
                  conversation: active[index],
                  onTap: () => _openChat(active[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
