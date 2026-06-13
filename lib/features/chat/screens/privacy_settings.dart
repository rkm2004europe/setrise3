import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _lastSeen = true, _readReceipts = true, _screenshot = false, _encrypt = false;

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
                  _Section(title: 'الخصوصية', children: [
                    _Switch(title: 'إظهار آخر ظهور', value: _lastSeen, onChanged: (v) => setState(() => _lastSeen = v)),
                    _Switch(title: 'إيصالات القراءة', value: _readReceipts, onChanged: (v) => setState(() => _readReceipts = v)),
                    _Switch(title: 'منع لقطات الشاشة', value: _screenshot, onChanged: (v) => setState(() => _screenshot = v)),
                  ]),
                  const SizedBox(height: 16),
                  _Section(title: 'الأمان', children: [
                    _Switch(title: 'التشفير', value: _encrypt, onChanged: (v) => setState(() => _encrypt = v)),
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
      const Text('إعدادات الخصوصية', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
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

class _Switch extends StatelessWidget {
  final String title; final bool value; final Function(bool) onChanged;
  const _Switch({required this.title, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => SwitchListTile(title: Text(title, style: const TextStyle(color: ChatColors.text)), value: value, onChanged: onChanged, activeColor: ChatColors.accent);
}
