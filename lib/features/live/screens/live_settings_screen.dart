import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'stream_settings_screen.dart';
import 'stream_reminder_screen.dart';

class LiveSettingsScreen extends StatefulWidget {
  const LiveSettingsScreen({super.key});

  @override
  State<LiveSettingsScreen> createState() => _LiveSettingsScreenState();
}

class _LiveSettingsScreenState extends State<LiveSettingsScreen> {
  bool _notifyFavorites = true;
  bool _autoJoin = false;

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
                  _section('الإشعارات'),
                  SwitchListTile(
                    title: const Text('إشعارات المفضلة', style: TextStyle(color: LiveColors.text)),
                    value: _notifyFavorites,
                    onChanged: (v) => setState(() => _notifyFavorites = v),
                    activeColor: LiveColors.accent,
                  ),
                  _section('الإعدادات'),
                  ListTile(
                    leading: const Icon(Icons.settings, color: LiveColors.text),
                    title: const Text('إعدادات البث', style: TextStyle(color: LiveColors.text)),
                    trailing: const Icon(Icons.chevron_right, color: LiveColors.text2),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StreamSettingsScreen())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.alarm, color: LiveColors.text),
                    title: const Text('تذكيرات البث', style: TextStyle(color: LiveColors.text)),
                    trailing: const Icon(Icons.chevron_right, color: LiveColors.text2),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StreamReminderScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 16),
        child: Text(title, style: const TextStyle(color: LiveColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
      );

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('الإعدادات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
