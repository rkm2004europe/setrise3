import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AiDjScreen extends StatelessWidget {
  const AiDjScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.music_note, size: 64, color: MusicColors.accent),
            const SizedBox(height: 16),
            const Text('AI DJ', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Your personal AI DJ is ready', style: TextStyle(color: MusicColors.text2)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), decoration: BoxDecoration(color: MusicColors.accent, borderRadius: BorderRadius.circular(14)), child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
          ]),
        ),
      ),
    );
  }
}
