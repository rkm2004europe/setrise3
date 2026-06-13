import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ExportChatScreen extends StatelessWidget {
  const ExportChatScreen({super.key});

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
                  _Section(title: 'تصدير المحادثة', children: [
                    ListTile(title: const Text('PDF', style: TextStyle(color: ChatColors.text)), leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent), onTap: () {}),
                    ListTile(title: const Text('TXT', style: TextStyle(color: ChatColors.text)), leading: const Icon(Icons.text_snippet, color: ChatColors.accent), onTap: () {}),
                    ListTile(title: const Text('JSON', style: TextStyle(color: ChatColors.text)), leading: const Icon(Icons.code, color: ChatColors.text2), onTap: () {}),
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
      const Text('تصدير المحادثة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
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
