import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveNotificationScreen extends StatelessWidget {
  const LiveNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'user': 'Sara', 'action': 'بدأ بثًا', 'time': 'قبل 5 دقائق'},
      {'user': 'Omar', 'action': 'أرسل لك هدية', 'time': 'قبل 10 دقائق'},
      {'user': 'Ahmed', 'action': 'دعاك للانضمام', 'time': 'قبل ساعة'},
    ];

    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (_, i) {
                  final n = notifications[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: const Icon(Icons.notifications, color: LiveColors.accent)),
                    title: Text(n['user']!, style: const TextStyle(color: LiveColors.text)),
                    subtitle: Text(n['action']!, style: const TextStyle(color: LiveColors.text2)),
                    trailing: Text(n['time']!, style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
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
        child: Row(children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('الإشعارات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
