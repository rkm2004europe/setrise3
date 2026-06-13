import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../controllers/block_controller.dart';

class BlockedUsersScreen extends StatelessWidget {
  final BlockController controller;
  const BlockedUsersScreen({super.key, required this.controller});

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
                  const Text('المحظورون', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.blocked.length,
                itemBuilder: (ctx, i) {
                  final user = controller.blocked[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: ChatColors.surface, child: Text(user.avatar)),
                    title: Text(user.name, style: const TextStyle(color: ChatColors.text)),
                    trailing: TextButton(
                      onPressed: () => controller.unblock(user.id),
                      child: const Text('إلغاء الحظر', style: TextStyle(color: ChatColors.accent)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
