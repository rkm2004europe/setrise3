// lib/features/home/screens/widgets/bottom_nav.dart

import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final Function(int) onTap;
  final bool showAlertBadge;

  const BottomNav({super.key, required this.onTap, this.showAlertBadge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.07)))),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(0, Icons.chat_bubble_rounded,    'Messages'),
              _item(1, Icons.notifications_rounded,  'Alerts', badge: showAlertBadge),
              _createBtn(),
              _item(3, Icons.person_rounded,         'Profile'),
              _item(4, Icons.home_rounded,            'Home'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int i, IconData icon, String label, {bool badge = false}) {
    return GestureDetector(
      onTap: () => onTap(i),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(clipBehavior: Clip.none, children: [
            Icon(icon, color: Colors.white54, size: 26),
            if (badge)
              Positioned(right: -2, top: -2,
                child: Container(width: 12, height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                  child: const Center(child: Text('3',
                    style: TextStyle(color: Colors.white, fontSize: 8,
                      fontWeight: FontWeight.bold))))),
          ]),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10,
            fontFamily: 'Inter')),
        ]),
      ),
    );
  }

  Widget _createBtn() {
    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(width: 52, height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.3),
            blurRadius: 8, offset: const Offset(0, 2))]),
        child: const Center(child: Text('+',
          style: TextStyle(color: Colors.black, fontSize: 24,
            fontWeight: FontWeight.bold, height: 1.1)))),
    );
  }
}
