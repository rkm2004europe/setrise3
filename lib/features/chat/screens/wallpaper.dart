import 'package:flutter/material.dart';
import '../theme/colors.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [ChatColors.bg, const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460), const Color(0xFF533483)];
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
                  const Text('الخلفيات', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                children: colors.map((c) => GestureDetector(
                  onTap: () { Navigator.pop(context); },
                  child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white24))),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
