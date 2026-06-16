import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StreamSettingsScreen extends StatefulWidget {
  const StreamSettingsScreen({super.key});

  @override
  State<StreamSettingsScreen> createState() => _StreamSettingsScreenState();
}

class _StreamSettingsScreenState extends State<StreamSettingsScreen> {
  String _quality = 'HD';
  bool _mirrorCamera = false, _beautyFilter = true, _guestRequests = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSection('جودة البث', [
                    ListTile(title: const Text('HD', style: TextStyle(color: LiveColors.text)), trailing: _quality == 'HD' ? const Icon(Icons.check, color: LiveColors.accent) : null, onTap: () => setState(() => _quality = 'HD')),
                    ListTile(title: const Text('Full HD', style: TextStyle(color: LiveColors.text)), trailing: _quality == 'Full HD' ? const Icon(Icons.check, color: LiveColors.accent) : null, onTap: () => setState(() => _quality = 'Full HD')),
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('إعدادات الكاميرا', [
                    SwitchListTile(title: const Text('عكس الكاميرا', style: TextStyle(color: LiveColors.text)), value: _mirrorCamera, onChanged: (v) => setState(() => _mirrorCamera = v), activeColor: LiveColors.accent),
                    SwitchListTile(title: const Text('فلتر تجميل', style: TextStyle(color: LiveColors.text)), value: _beautyFilter, onChanged: (v) => setState(() => _beautyFilter = v), activeColor: LiveColors.accent),
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('الضيوف', [
                    SwitchListTile(title: const Text('قبول طلبات الضيوف', style: TextStyle(color: LiveColors.text)), value: _guestRequests, onChanged: (v) => setState(() => _guestRequests = v), activeColor: LiveColors.accent),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: LiveColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
    const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)), child: Column(children: children)),
  ]);

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('إعدادات البث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
