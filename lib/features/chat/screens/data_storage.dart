import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DataStorageScreen extends StatelessWidget {
  const DataStorageScreen({super.key});

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
                  const Text('البيانات والتخزين', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Section(title: 'استخدام الشبكة', children: [
                    ListTile(title: const Text('تنزيل الوسائط تلقائياً', style: TextStyle(color: ChatColors.text)), trailing: const Text('Wi-Fi فقط', style: TextStyle(color: ChatColors.text2))),
                    ListTile(title: const Text('جودة الصور', style: TextStyle(color: ChatColors.text)), trailing: const Text('عالية', style: TextStyle(color: ChatColors.text2))),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'التخزين', children: [
                    ListTile(title: const Text('إجمالي المساحة', style: TextStyle(color: ChatColors.text)), trailing: const Text('24.5 ميغابايت', style: TextStyle(color: ChatColors.text2))),
                    ListTile(title: const Text('مسح ذاكرة التخزين المؤقت', style: TextStyle(color: ChatColors.text)), trailing: const Icon(Icons.cleaning_services, color: ChatColors.accent), onTap: () {}),
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
