import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class VoiceReactionScreen extends StatelessWidget {
  const VoiceReactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.keyboard_voice, size: 80, color: LiveColors.accent),
            const SizedBox(height: 16),
            const Text('تفاعل بصوتك', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(color: LiveColors.accent, shape: BoxShape.circle),
                child: const Icon(Icons.mic, color: Colors.white, size: 36),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
