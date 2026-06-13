import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatBackupTile extends StatelessWidget {
  final String lastBackup;
  final VoidCallback onBackup;

  const ChatBackupTile({super.key, required this.lastBackup, required this.onBackup});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.cloud, color: ChatColors.accent),
      title: const Text('النسخ الاحتياطي', style: TextStyle(color: ChatColors.text)),
      subtitle: Text('آخر نسخة: $lastBackup', style: const TextStyle(color: ChatColors.text2)),
      onTap: onBackup,
    );
  }
}
