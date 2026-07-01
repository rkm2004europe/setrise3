import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LyricsScreen extends StatelessWidget {
  final String trackTitle;
  const LyricsScreen({super.key, required this.trackTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MusicColors.text)),
                const SizedBox(width: 12),
                Text(trackTitle, style: const TextStyle(color: MusicColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: const [
                  Text('[المقطع الأول]', style: TextStyle(color: MusicColors.accent, fontWeight: FontWeight.w700, fontSize: 16)),
                  SizedBox(height: 12),
                  Text('الكلمات تظهر هنا...', style: TextStyle(color: MusicColors.text2, height: 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
