import 'package:flutter/material.dart';
import '../../home/theme/app_colors.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للإشعارات
    final alerts = [
      {'title': 'أعجب بتعليقك', 'user': '@ahmed_k', 'time': 'منذ 5 دقائق'},
      {'title': 'بدأ متابعتك', 'user': '@sara_m', 'time': 'منذ 10 دقائق'},
      {'title': 'رد على منشورك', 'user': '@omar_t', 'time': 'منذ ساعة'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'الإشعارات',
                    style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: alerts.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.grey,
                    child: const Icon(Icons.person, color: AppColors.white),
                  ),
                  title: Text(alerts[i]['user']!, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text(alerts[i]['title']!, style: const TextStyle(color: AppColors.grey2)),
                  trailing: Text(alerts[i]['time']!, style: const TextStyle(color: AppColors.grey2, fontSize: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
