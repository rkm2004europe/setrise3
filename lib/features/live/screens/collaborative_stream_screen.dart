import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CollaborativeStreamScreen extends StatelessWidget {
  const CollaborativeStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.group_work, size: 64, color: LiveColors.accent),
            const SizedBox(height: 16),
            const Text('بث تعاوني', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('ادعُ مضيفًا آخر للانضمام', style: TextStyle(color: LiveColors.text2)),
          ]),
        ),
      ),
    );
  }
}
