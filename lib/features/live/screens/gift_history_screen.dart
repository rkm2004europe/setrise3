import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GiftHistoryScreen extends StatelessWidget {
  const GiftHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للتاريخ
    final history = [
      {'user': 'Ahmed', 'gift': '🚗', 'time': 'قبل 5 دقائق', 'type': 'أرسلت'},
      {'user': 'Sara', 'gift': '❤️', 'time': 'قبل ساعة', 'type': 'استلمت'},
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
                itemCount: history.length,
                itemBuilder: (_, i) {
                  final h = history[i];
                  return ListTile(
                    leading: Text(h['gift']!, style: const TextStyle(fontSize: 28)),
                    title: Text(h['user']!, style: const TextStyle(color: LiveColors.text)),
                    subtitle: Text(h['time']!, style: const TextStyle(color: LiveColors.text2)),
                    trailing: Text(h['type']!, style: const TextStyle(color: LiveColors.gold)),
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
            const Text('سجل الهدايا', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
