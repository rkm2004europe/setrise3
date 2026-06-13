import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../data/conversations.dart';
import 'chat.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final _ctrl = TextEditingController();
  List<User> _results = [];

  void _search(String q) {
    final all = [u1, u2, u3, u4];
    setState(() => _results = q.isEmpty ? all : all.where((u) => u.name.toLowerCase().contains(q.toLowerCase())).toList());
  }

  @override
  void initState() { super.initState(); _search(''); }

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
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: ChatColors.text)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      style: const TextStyle(color: ChatColors.text),
                      decoration: InputDecoration(hintText: 'اسم المستخدم...', hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)), border: InputBorder.none),
                      onChanged: _search,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (ctx, i) {
                  final u = _results[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: ChatColors.surface, child: Text(u.avatar)),
                    title: Text(u.name, style: const TextStyle(color: ChatColors.text)),
                    subtitle: Text(u.username, style: const TextStyle(color: ChatColors.text2)),
                    onTap: () {
                      final conv = Conversation(id: 'new_${u.id}', user: u, type: ConvType.friend, lastMessage: null, unread: 0, isArchived: false, isMuted: false, updatedAt: DateTime.now());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChatScreen(conversation: conv)));
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
