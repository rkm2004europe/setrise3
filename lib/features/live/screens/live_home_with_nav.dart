import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/live_bottom_nav.dart';
import 'live_main_tab_screen.dart';
import 'live_discover_screen.dart';
import 'gift_collection_screen.dart';
import 'live_profile_screen.dart';

class LiveHomeWithNav extends StatefulWidget {
  const LiveHomeWithNav({super.key});

  @override
  State<LiveHomeWithNav> createState() => _LiveHomeWithNavState();
}

class _LiveHomeWithNavState extends State<LiveHomeWithNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    LiveMainTabScreen(),
    LiveDiscoverScreen(),
    GiftCollectionScreen(),
    LiveProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: _screens[_currentIndex],
      bottomNavigationBar: LiveBottomNav(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
    );
  }
}
