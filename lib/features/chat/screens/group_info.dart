import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../data/conversations.dart';

class GroupInfoScreen extends StatefulWidget {
  final Conversation conversation;
  const GroupInfoScreen({super.key, required this.conversation});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final conv = widget.conversation;
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
                  const SizedBox(width: 12),
                  Text(conv.displayName, style: const TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Group avatar
                  Center(
                    child: Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: ChatColors.surface),
                      child: Center(child: Text(conv.displayAvatar, style: const TextStyle(fontSize: 42))),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(child: Text('${conv.membersCount ?? 0} أعضاء', style: const TextStyle(color: ChatColors.text2))),
                  const SizedBox(height: 20),
                  _Section(title: 'الأعضاء', children: [
                    ...([u1, u2, u3].map((u) => ListTile(
                      leading: CircleAvatar(backgroundColor: ChatColors.surface, child: Text(u.avatar)),
                      title: Text(u.name, style: const TextStyle(color: ChatColors.text)),
                      subtitle: Text(u.username, style: const TextStyle(color: ChatColors.text2)),
                    ))),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'الإعدادات', children: [
                    SwitchListTile(title: const Text('كتم الإشعارات', style: TextStyle(color: ChatColors.text)), value: false, onChanged: (_) {}, activeColor: ChatColors.accent),
                    ListTile(title: const Text('مغادرة المجموعة', style: TextStyle(color: Colors.redAccent)), onTap: () => Navigator.pop(context)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: ChatColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(14)),
          child: Column(children: children),
        ),
      ],
    );
  }
}
