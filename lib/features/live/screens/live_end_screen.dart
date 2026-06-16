import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveEndScreen extends StatelessWidget {
  final int viewers, gifts, durationMinutes;
  const LiveEndScreen({super.key, required this.viewers, required this.gifts, required this.durationMinutes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('🔴', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text('انتهى البث', style: TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            _stat('المشاهدات', '$viewers'),
            _stat('الهدايا', '$gifts 🪙'),
            _stat('المدة', '$durationMinutes دقيقة'),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)), child: const Text('عودة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text('$label: $value', style: const TextStyle(color: LiveColors.text, fontSize: 16)),
  );
}
