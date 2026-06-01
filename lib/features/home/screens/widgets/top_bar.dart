// lib/features/home/screens/widgets/top_bar.dart

import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final bool panelOpen;
  final VoidCallback onSetRizeTap;
  final String activeTabName;
  final bool showSearchIcon;
  final VoidCallback? onSearchTap;

  const TopBar({
    super.key,
    required this.panelOpen,
    required this.onSetRizeTap,
    required this.activeTabName,
    this.showSearchIcon = false,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = activeTabName == 'SetRize'
        ? 'SetRize'
        : 'SetRize $activeTabName';

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Row(children: [
        // ── SetRize + سهم ──────────────────────────────────
        AnimatedScale(
          scale: panelOpen ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 260),
          child: GestureDetector(
            onTap: onSetRizeTap,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                ).createShader(b),
                child: Text(displayText,
                  style: const TextStyle(color: Colors.white, fontSize: 18,
                    fontWeight: FontWeight.w900, fontFamily: 'Inter',
                    letterSpacing: -0.3)),
              ),
              const SizedBox(width: 2),
              AnimatedRotation(
                turns: panelOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 260),
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.white, size: 20)),
            ]),
          ),
        ),

        const Spacer(),

        // ── Search ─────────────────────────────────────────
        if (showSearchIcon && onSearchTap != null)
          GestureDetector(
            onTap: onSearchTap,
            child: Container(width: 36, height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.15))),
              child: const Icon(Icons.search_rounded, color: Colors.white, size: 20)),
          ),
      ]),
    );
  }
}
