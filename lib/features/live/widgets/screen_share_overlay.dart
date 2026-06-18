Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScreenShareOverlay extends StatelessWidget {
  const ScreenShareOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveColors.bg.withOpacity(0.8),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.screen_share, size: 64, color: LiveColors.accent),
          const SizedBox(height: 16),
          const Text('مشاركة الشاشة نشطة', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
              child: const Text('إيقاف', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
