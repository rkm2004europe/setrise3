import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../data/conversations.dart';
import '../widgets/tile.dart';
import 'chat.dart';

class SearchChatScreen extends StatefulWidget {
  const SearchChatScreen({super.key});

  @override
  State<SearchChatScreen> createState() => _SearchChatScreenState();
}

class _SearchChatScreenState extends State<SearchChatScreen> {
  final _ctrl = TextEditingController();
  List<Conversation> _results = [];

  void _search(String q) {
    setState(() {
      _results = q.isEmpty ? [] : mockConversations().where((c) => c.displayName.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      autofocus: true,
                      style: const TextStyle(color: ChatColors.text),
                      decoration: InputDecoration(
                        hintText: 'بحث...',
                        hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)),
                        border: InputBorder.none,
                      ),
                      onChanged: _search,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (ctx, i) => ConversationTile(
                  conversation: _results[i],
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(conversation: _results[i]))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
