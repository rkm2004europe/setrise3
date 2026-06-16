import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SoundEffectButton extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;
  const SoundEffectButton({super.key, required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48, height: 48,
        decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(14)),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
      ),
    );
  }
}
