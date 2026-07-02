import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ListenTogetherScreen extends StatelessWidget {
  const ListenTogetherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.headphones, size: 64, color: MusicColors.accent),
            const SizedBox(height: 16),
            const Text('Listen Together', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Invite friends to listen', style: TextStyle(color: MusicColors.text2)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), decoration: BoxDecoration(color: MusicColors.accent, borderRadius: BorderRadius.circular(14)), child: const Text('Start Session', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
          ]),
        ),
      ),
    );
  }
}
