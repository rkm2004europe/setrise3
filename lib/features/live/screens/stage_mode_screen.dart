import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StageModeScreen extends StatelessWidget {
  const StageModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.theater_comedy, size: 64, color: LiveColors.accent),
            const SizedBox(height: 16),
            const Text('وضع المسرح', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('بث متعدد المضيفين معًا', style: TextStyle(color: LiveColors.text2)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                child: const Text('ابدأ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
