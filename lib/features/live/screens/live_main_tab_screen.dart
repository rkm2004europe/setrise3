import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'live_feed_screen.dart';
import 'game_live_screen.dart';
import 'audio_rooms_feed_screen.dart';
import 'following_streamers_screen.dart';
import '../controllers/follow_controller.dart';

class LiveMainTabScreen extends StatefulWidget {
  const LiveMainTabScreen({super.key});

  @override
  State<LiveMainTabScreen> createState() => _LiveMainTabScreenState();
}

class _LiveMainTabScreenState extends State<LiveMainTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final FollowController _followCtrl = FollowController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي مع تبويبات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text('Live', style: TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
                  const Spacer(),
                  // زر البحث
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: LiveColors.surface, shape: BoxShape.circle),
                      child: const Icon(Icons.search, color: LiveColors.text, size: 22),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // زر المتابَعين
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FollowingStreamersScreen(controller: _followCtrl))),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: LiveColors.surface, shape: BoxShape.circle),
                      child: const Icon(Icons.people, color: LiveColors.text, size: 22),
                    ),
                  ),
                ],
              ),
            ),
            // تبويبات
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(12)),
              child: TabBar(
                controller: _tabCtrl,
                indicator: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: LiveColors.text2,
                tabs: const [
                  Tab(text: 'الكل'),
                  Tab(text: 'ألعاب'),
                  Tab(text: 'غرف صوتية'),
                  Tab(text: 'متابَعون'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  const LiveFeedScreen(),
                  const GameLiveScreen(),
                  const AudioRoomsFeedScreen(),
                  FollowingStreamersScreen(controller: _followCtrl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
