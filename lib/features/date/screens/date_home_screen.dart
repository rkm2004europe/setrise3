import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import '../data/mock_date_users.dart';
import '../widgets/date_card.dart';
import 'date_profile_screen.dart';
import 'blind_date_screen.dart';
import 'speed_date_screen.dart';
import 'match_screen.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart' as chat;

class DateHomeScreen extends StatefulWidget {
  const DateHomeScreen({super.key});

  @override
  State<DateHomeScreen> createState() => _DateHomeScreenState();
}

class _DateHomeScreenState extends State<DateHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  late List<DateUserModel> _users;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    _users = List.from(mockDateUsers)..shuffle();
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _onSwipeRight(DateUserModel user) {
    HapticFeedback.mediumImpact();
    // محاكاة تطابق بنسبة 50%
    if (DateTime.now().millisecond.isEven) {
      // فتح شاشة التطابق (التي تفتح الشات لاحقاً)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MatchScreen(matchedUser: user),
        ),
      );
    }
    _nextUser();
  }

  void _onSwipeLeft(DateUserModel user) {
    HapticFeedback.lightImpact();
    _nextUser();
  }

  void _nextUser() {
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        _users = List.from(mockDateUsers)..shuffle();
        _currentIndex = 0;
      }
    });
  }

  void _onTap(DateUserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DateProfileScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي مع التبويبات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      color: DateColors.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: DateColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabCtrl,
                      indicator: BoxDecoration(
                        color: DateColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: DateColors.text2,
                      labelStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                      tabs: const [
                        Tab(text: 'استكشاف'),
                        Tab(text: 'مجهول'),
                        Tab(text: 'سريع'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // محتوى التبويبات
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  _buildExploreTab(),
                  const BlindDateScreen(),
                  const SpeedDateScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreTab() {
    return _users.isEmpty
        ? const Center(
            child: Text(
              'لا يوجد المزيد من المستخدمين',
              style: TextStyle(color: DateColors.text2),
            ),
          )
        : Stack(
            children: List.generate(
              _users.length - _currentIndex > 3
                  ? 3
                  : _users.length - _currentIndex,
              (i) {
                final user = _users[_currentIndex + i];
                return Positioned(
                  bottom: i * 10.0,
                  left: 8,
                  right: 8,
                  child: DateCard(
                    user: user,
                    isTop: i == 0,
                    onSwipeRight: () => _onSwipeRight(user),
                    onSwipeLeft: () => _onSwipeLeft(user),
                    onSwipeUp: () => HapticFeedback.selectionClick(),
                    onSwipeDown: () => HapticFeedback.selectionClick(),
                    onTap: () => _onTap(user),
                  ),
                );
              },
            ),
          );
  }
}
