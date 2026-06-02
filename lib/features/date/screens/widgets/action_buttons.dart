// lib/features/date/screens/widgets/action_buttons.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onNope;
  final VoidCallback onSuperLike;
  final VoidCallback onLike;

  const ActionButtons({
    super.key,
    required this.onNope,
    required this.onSuperLike,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ✕ Nope
        _Btn(
          size: 58, icon: Icons.close_rounded,
          color: const Color(0xFFFF3B30),
          onTap: () { HapticFeedback.mediumImpact(); onNope(); }),
        const SizedBox(width: 16),
        // ⭐ Super Like
        _Btn(
          size: 50, icon: Icons.star_rounded,
          color: const Color(0xFF007AFF),
          onTap: () { HapticFeedback.heavyImpact(); onSuperLike(); }),
        const SizedBox(width: 16),
        // ❤️ Like
        _Btn(
          size: 58, icon: Icons.favorite_rounded,
          color: const Color(0xFF34C759),
          onTap: () { HapticFeedback.mediumImpact(); onLike(); }),
      ],
    );
  }
}

class _Btn extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _Btn({required this.size, required this.icon,
    required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.5), width: 2),
        boxShadow: [BoxShadow(
          color: color.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 4))]),
      child: Icon(icon, color: color, size: size * 0.48)));
}

