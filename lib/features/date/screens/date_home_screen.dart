import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import '../data/mock_date_users.dart';
import '../widgets/date_card.dart';
import 'date_profile_screen.dart';

class DateHomeScreen extends StatefulWidget {
  const DateHomeScreen({super.key});

  @override
  State<DateHomeScreen> createState() => _DateHomeScreenState();
}

class _DateHomeScreenState extends State<DateHomeScreen> {
  late List<DateUserModel> _users;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _users = List.from(mockDateUsers)..shuffle();
  }

  void _onSwipeRight(DateUserModel user) {
    HapticFeedback.mediumImpact();
    // TODO: check for match
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        _users = List.from(mockDateUsers)..shuffle();
        _currentIndex = 0;
      }
    });
  }

  void _onSwipeLeft(DateUserModel user) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        _users = List.from(mockDateUsers)..shuffle();
        _currentIndex = 0;
      }
    });
  }

  void _onSwipeUp() {
    HapticFeedback.selectionClick();
  }

  void _onSwipeDown() {
    HapticFeedback.selectionClick();
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
            // شريط علوي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.tune, color: DateColors.text, size: 24),
                  ),
                ],
              ),
            ),
            // بطاقات السحب
            Expanded(
              child: _users.isEmpty
                  ? const Center(
                      child: Text(
                        'لا يوجد المزيد من المستخدمين',
                        style: TextStyle(color: DateColors.text2),
                      ),
                    )
                  : Stack(
                      children: List.generate(
                        _users.length - _currentIndex > 3 ? 3 : _users.length - _currentIndex,
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
                              onSwipeUp: _onSwipeUp,
                              onSwipeDown: _onSwipeDown,
                              onTap: () => _onTap(user),
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
