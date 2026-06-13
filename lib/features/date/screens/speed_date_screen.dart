import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import '../data/mock_date_users.dart';
import '../widgets/speed_date_card.dart';
import 'match_screen.dart';

class SpeedDateScreen extends StatefulWidget {
  const SpeedDateScreen({super.key});

  @override
  State<SpeedDateScreen> createState() => _SpeedDateScreenState();
}

class _SpeedDateScreenState extends State<SpeedDateScreen> {
  late List<DateUserModel> _users;
  int _currentIndex = 0;
  int _timeLeft = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _users = List.from(mockDateUsers)..shuffle();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _timeLeft = 15);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _timeLeft--;
        if (_timeLeft <= 0) {
          t.cancel();
          _onTimeout();
        }
      });
    });
  }

  void _onLike(DateUserModel user) {
    HapticFeedback.mediumImpact();
    _timer?.cancel();
    // محاكاة تطابق بنسبة 40%
    if (DateTime.now().millisecond % 3 == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MatchScreen(matchedUser: user)),
      );
    } else {
      _nextUser();
    }
  }

  void _onNope(DateUserModel user) {
    HapticFeedback.lightImpact();
    _timer?.cancel();
    _nextUser();
  }

  void _onTimeout() {
    HapticFeedback.selectionClick();
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
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (_users.isEmpty) {
      return const Center(
        child: Text(
          'لا يوجد مواعيد سريعة',
          style: TextStyle(color: DateColors.text2),
        ),
      );
    }

    return Stack(
      children: List.generate(
        _users.length - _currentIndex > 3 ? 3 : _users.length - _currentIndex,
        (i) {
          final user = _users[_currentIndex + i];
          return Positioned(
            bottom: i * 10.0,
            left: 8,
            right: 8,
            child: SpeedDateCard(
              user: user,
              timeLeft: _timeLeft,
              isTop: i == 0,
              onLike: () => _onLike(user),
              onNope: () => _onNope(user),
              onTimeout: _onTimeout,
            ),
          );
        },
      ),
    );
  }
}
