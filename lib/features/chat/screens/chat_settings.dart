import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatSettingsScreen extends StatefulWidget {
  const ChatSettingsScreen({super.key});

  @override
  State<ChatSettingsScreen> createState() => _ChatSettingsScreenState();
}

class _ChatSettingsScreenState extends State<ChatSettingsScreen> {
  bool _notify = true, _sound = true, _vibrate = true, _preview = true, _encrypt = false;

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
                  const Text('إعدادات الشات', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Section(title: 'الإشعارات', children: [
                    _Switch(title: 'تفعيل الإشعارات', value: _notify, onChanged: (v) => setState(() => _notify = v)),
                    _Switch(title: 'الصوت', value: _sound, onChanged: (v) => setState(() => _sound = v)),
                    _Switch(title: 'الاهتزاز', value: _vibrate, onChanged: (v) => setState(() => _vibrate = v)),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'الخصوصية', children: [
                    _Switch(title: 'معاينة الرسائل', value: _preview, onChanged: (v) => setState(() => _preview = v)),
                    _Switch(title: 'التشفير', value: _encrypt, onChanged: (v) => setState(() => _encrypt = v)),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'النسخ الاحتياطي', children: [
                    ListTile(title: const Text('نسخ احتياطي الآن', style: TextStyle(color: ChatColors.text)), trailing: const Icon(Icons.cloud_upload, color: ChatColors.accent), onTap: () {}),
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

class _Switch extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  const _Switch({required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(title: Text(title, style: const TextStyle(color: ChatColors.text)), value: value, onChanged: onChanged, activeColor: ChatColors.accent);
  }
}
