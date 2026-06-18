import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GoLiveNotificationScreen extends StatelessWidget {
  const GoLiveNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.notifications_active, size: 64, color: LiveColors.accent),
            const SizedBox(height: 20),
            const Text('إشعارات البث', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const Text('سيتم إشعار متابعيك عند بدء البث', style: TextStyle(color: LiveColors.text2)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('تفعيل الإشعارات', style: TextStyle(color: LiveColors.text)),
              value: true,
              onChanged: (_) {},
              activeColor: LiveColors.accent,
            ),
          ]),
        ),
      ),
    );
  }
}
