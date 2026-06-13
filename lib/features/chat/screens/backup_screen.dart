import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../services/cloud_service.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  final CloudService _cloud = CloudService();
  String _lastBackup = '2025-01-01 10:00';

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
                  const Text('النسخ الاحتياطي', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ChatBackupTile(lastBackup: _lastBackup, onBackup: () async {
                    await _cloud.backup();
                    setState(() => _lastBackup = DateTime.now().toString().substring(0, 16));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
