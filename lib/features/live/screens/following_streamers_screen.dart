Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/follow_controller.dart';
import '../../user/screens/user_preview_sheet.dart';

class FollowingStreamersScreen extends StatelessWidget {
  final FollowController controller;
  const FollowingStreamersScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.followedHosts.length,
                itemBuilder: (_, i) {
                  final host = controller.followedHosts[i];
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () => showUserPreviewSheet(
                        context,
                        userId: host['id'] as String,
                        userName: host['name'] as String,
                        username: '@${host['name']}',
                        accent: LiveColors.accent,
                      ),
                      child: CircleAvatar(
                        backgroundColor: LiveColors.accent.withOpacity(0.1),
                        child: Text(host['avatar'] as String, style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                    title: Text(host['name'] as String, style: const TextStyle(color: LiveColors.text)),
                    subtitle: Text(host['live'] == true ? 'مباشر الآن' : 'غير متصل',
                        style: TextStyle(color: host['live'] == true ? LiveColors.accent : LiveColors.text2)),
                    trailing: host['live'] == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: LiveColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('انضم', style: TextStyle(color: Colors.white, fontSize: 12)),
                          )
                        : const Icon(Icons.notifications_off, color: LiveColors.text2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
            const SizedBox(width: 12),
            const Text('المتابَعون', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
