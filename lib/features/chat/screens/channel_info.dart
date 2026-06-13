import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class ChannelInfoScreen extends StatelessWidget {
  final Conversation conversation;
  const ChannelInfoScreen({super.key, required this.conversation});

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
                  Text(conversation.displayName, style: const TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(
                    child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: ChatColors.surface), child: Center(child: Text(conversation.displayAvatar, style: const TextStyle(fontSize: 42)))),
                  ),
                  const SizedBox(height: 12),
                  Center(child: Text('${conversation.membersCount ?? 0} مشترك', style: const TextStyle(color: ChatColors.text2))),
                  const SizedBox(height: 20),
                  _Section(title: 'الوصف', children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text('قناة رسمية لمشروع SetRise. آخر الأخبار والتحديثات.', style: const TextStyle(color: ChatColors.text)),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'الإجراءات', children: [
                    ListTile(title: const Text('مشاركة الرابط', style: TextStyle(color: ChatColors.accent)), onTap: () {}),
                    ListTile(title: const Text('إلغاء الاشتراك', style: TextStyle(color: Colors.redAccent)), onTap: () => Navigator.pop(context)),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: ChatColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Container(decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(14)), child: Column(children: children)),
    ]);
  }
}
