import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeSettingsScreen extends StatefulWidget {
  const RizeSettingsScreen({super.key});

  @override
  State<RizeSettingsScreen> createState() => _RizeSettingsScreenState();
}

class _RizeSettingsScreenState extends State<RizeSettingsScreen> {
  bool _notifyLikes = true;
  bool _notifyReplies = true;
  bool _notifyFollows = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Rize Settings', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSwitch('Notify when someone likes your Rize', _notifyLikes, (v) => setState(() => _notifyLikes = v)),
                  _buildSwitch('Notify when someone replies', _notifyReplies, (v) => setState(() => _notifyReplies = v)),
                  _buildSwitch('Notify when someone follows you', _notifyFollows, (v) => setState(() => _notifyFollows = v)),
                  const SizedBox(height: 20),
                  const Text('Data & Privacy', style: TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
                  ListTile(
                    title: const Text('Download your data', style: TextStyle(color: NewsColors.textPrimary)),
                    trailing: const Icon(Icons.download, color: NewsColors.textSecondary),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Delete account', style: TextStyle(color: NewsColors.likeActive)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: NewsColors.textPrimary)),
      value: value,
      onChanged: onChanged,
      activeColor: NewsColors.accent,
    );
  }
}
