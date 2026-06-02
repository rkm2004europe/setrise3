// lib/features/date/screens/dating_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/date/screens/tabs/discover_tab.dart';
import 'package:setrise/features/date/screens/tabs/matches_tab.dart';

class DatingScreen extends StatefulWidget {
  const DatingScreen({super.key});

  @override
  State<DatingScreen> createState() => _DatingScreenState();
}

class _DatingScreenState extends State<DatingScreen> {
  int  _tab       = 0;
  int  _newMatches = 0;

  static const _accent = Color(0xFFFF3B30);

  void _onNewMatch() => setState(() => _newMatches++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: IndexedStack(index: _tab, children: [
        DiscoverTab(onNewMatch: _onNewMatch),
        const MatchesTab(),
      ])),
      bottomNavigationBar: _DatingBottomNav(
        current: _tab,
        matchBadge: _newMatches,
        onTap: (i) {
          HapticFeedback.selectionClick();
          setState(() {
            _tab = i;
            if (i == 1) _newMatches = 0;
          });
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// BOTTOM NAV
// ════════════════════════════════════════════════════════════

class _DatingBottomNav extends StatelessWidget {
  final int current;
  final int matchBadge;
  final Function(int) onTap;

  const _DatingBottomNav({
    required this.current, required this.matchBadge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white10))),
      child: SafeArea(top: false,
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(index: 0, icon: Icons.explore_rounded, label: 'Discover',
                active: current == 0, accent: const Color(0xFFFF3B30), onTap: onTap),
              _NavItem(index: 1, icon: Icons.favorite_rounded,    label: 'Matches',
                active: current == 1, accent: const Color(0xFFFF3B30),
                badge: matchBadge, onTap: onTap),
            ]))),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool active;
  final Color accent;
  final int badge;
  final Function(int) onTap;

  const _NavItem({required this.index, required this.icon, required this.label,
    required this.active, required this.accent, required this.onTap, this.badge = 0});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onTap(index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(children: [
        Icon(icon, color: active ? accent : Colors.white38, size: 28),
        if (badge > 0)
          Positioned(top: 0, right: 0,
            child: Container(width: 14, height: 14,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5)),
              child: Center(child: Text('$badge',
                style: const TextStyle(color: Colors.white, fontSize: 8,
                  fontWeight: FontWeight.w900))))),
      ]),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(
        color: active ? accent : Colors.white38,
        fontSize: 10, fontWeight: active ? FontWeight.w700 : FontWeight.w400,
        fontFamily: 'Inter')),
    ]));
}
