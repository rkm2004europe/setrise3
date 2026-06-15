import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../data/mock_live_rooms.dart';
import '../widgets/swipe_card.dart';
import 'live_room_screen.dart';
import 'schedule_live_screen.dart';
import 'map_discovery_screen.dart';

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen> {
  late List<LiveRoomModel> _rooms;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _rooms = mockLiveRooms.where((r) => r.isLive).toList()..shuffle();
  }

  void _onSwipeRight(LiveRoomModel room) {
    HapticFeedback.mediumImpact();
    // متابعة المضيف أو إبداء الإعجاب
    _nextRoom();
  }

  void _onSwipeLeft(LiveRoomModel room) {
    HapticFeedback.lightImpact();
    // تخطي
    _nextRoom();
  }

  void _nextRoom() {
    setState(() {
      if (_currentIndex < _rooms.length - 1) {
        _currentIndex++;
      } else {
        _rooms = mockLiveRooms.where((r) => r.isLive).toList()..shuffle();
        _currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text('Live', style: TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapDiscoveryScreen())),
                    child: const Icon(Icons.map, color: LiveColors.text, size: 24),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleLiveScreen())),
                    child: const Icon(Icons.schedule, color: LiveColors.text, size: 24),
                  ),
                ],
              ),
            ),
            // بطاقات السحب
            Expanded(
              child: _rooms.isEmpty
                  ? const Center(child: Text('لا توجد بثوث مباشرة', style: TextStyle(color: LiveColors.text2)))
                  : Stack(
                      children: List.generate(
                        _rooms.length - _currentIndex > 3 ? 3 : _rooms.length - _currentIndex,
                        (i) {
                          final room = _rooms[_currentIndex + i];
                          return Positioned(
                            bottom: i * 10.0,
                            left: 8,
                            right: 8,
                            child: SwipeCard(
                              room: room,
                              isTop: i == 0,
                              onSwipeRight: () => _onSwipeRight(room),
                              onSwipeLeft: () => _onSwipeLeft(room),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => LiveRoomScreen(room: room)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
