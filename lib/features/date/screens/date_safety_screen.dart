import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DateSafetyScreen extends StatefulWidget {
  const DateSafetyScreen({super.key});

  @override
  State<DateSafetyScreen> createState() => _DateSafetyScreenState();
}

class _DateSafetyScreenState extends State<DateSafetyScreen> {
  bool _shareLocation = false, _panicBtn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Section(title: 'جهات اتصال الطوارئ', children: [
                    ListTile(leading: const Icon(Icons.person, color: DateColors.text), title: const Text('أمي', style: TextStyle(color: DateColors.text)), trailing: const Text('+213 555 123 456', style: TextStyle(color: DateColors.text2))),
                    ListTile(leading: const Icon(Icons.person, color: DateColors.text), title: const Text('أخي', style: TextStyle(color: DateColors.text)), trailing: const Text('+213 555 789 012', style: TextStyle(color: DateColors.text2))),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'الأمان', children: [
                    SwitchListTile(title: const Text('مشاركة الموقع', style: TextStyle(color: DateColors.text)), value: _shareLocation, onChanged: (v) => setState(() => _shareLocation = v), activeColor: DateColors.accent),
                    SwitchListTile(title: const Text('زر الطوارئ', style: TextStyle(color: DateColors.text)), value: _panicBtn, onChanged: (v) => setState(() => _panicBtn = v), activeColor: DateColors.accent),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('مركز الأمان', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _Section extends StatelessWidget {
  final String title; final List<Widget> children;
  const _Section({required this.title, required this.children});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: DateColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
    const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(14)), child: Column(children: children)),
  ]);
}
