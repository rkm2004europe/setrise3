import 'package:flutter/material.dart';
import '../theme/colors.dart';

class LinkedDevicesScreen extends StatelessWidget {
  const LinkedDevicesScreen({super.key});

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
                  _Section(title: 'الأجهزة المرتبطة', children: [
                    ListTile(leading: const Icon(Icons.phone_android, color: ChatColors.text), title: const Text('هاتفك الحالي', style: TextStyle(color: ChatColors.text)), subtitle: const Text('متصل الآن', style: TextStyle(color: ChatColors.text2))),
                    ListTile(leading: const Icon(Icons.laptop, color: ChatColors.text2), title: const Text('حاسوب محمول', style: TextStyle(color: ChatColors.text)), subtitle: const Text('آخر اتصال: أمس', style: TextStyle(color: ChatColors.text2))),
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
      const Text('الأجهزة المرتبطة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
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
