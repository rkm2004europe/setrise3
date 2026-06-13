import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatBackupInfoScreen extends StatelessWidget {
  const ChatBackupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Section(title: 'معلومات النسخ الاحتياطي', children: [
                    ListTile(title: const Text('الحجم', style: TextStyle(color: ChatColors.text)), trailing: const Text('12.4 ميغابايت', style: TextStyle(color: ChatColors.text2))),
                    ListTile(title: const Text('آخر نسخة', style: TextStyle(color: ChatColors.text)), trailing: const Text('2025-01-01', style: TextStyle(color: ChatColors.text2))),
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

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
      const SizedBox(width: 12),
      const Text('النسخ الاحتياطي', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _Section extends StatelessWidget {
  final String title; final List<Widget> children;
  const _Section({required this.title, required this.children});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: ChatColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
    const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(14)), child: Column(children: children)),
  ]);
}
