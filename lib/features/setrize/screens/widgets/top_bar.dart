// lib/features/setrize/screens/widgets/top_bar.dart

import 'package:flutter/material.dart';

class SetrizeTopBar extends StatelessWidget {
  final VoidCallback onNotification;
  final VoidCallback onSearch;

  const SetrizeTopBar({super.key, required this.onNotification, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final topSafe = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(16, topSafe + 8, 16, 8),
      decoration: BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Colors.black.withOpacity(0.7), Colors.transparent])),
      child: Row(children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFFFF6584)]).createShader(b),
          child: const Text('Setrize', style: TextStyle(color: Colors.white, fontSize: 24,
            fontWeight: FontWeight.w900, fontFamily: 'Inter', letterSpacing: -0.5))),
        const Spacer(),
        _Btn(icon: Icons.search_rounded, onTap: onSearch),
        const SizedBox(width: 8),
        _Btn(icon: Icons.notifications_outlined, onTap: onNotification, badge: true),
      ]));
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool badge;
  const _Btn({required this.icon, required this.onTap, this.badge = false});

  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Stack(children: [
      Container(width: 38, height: 38,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1)),
        child: Icon(icon, color: Colors.white, size: 20)),
      if (badge)
        Positioned(top: 6, right: 6,
          child: Container(width: 8, height: 8,
            decoration: const BoxDecoration(color: Color(0xFFFF3B30), shape: BoxShape.circle))),
    ]));
}
