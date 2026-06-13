import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import '../data/mock_date_users.dart';
import '../widgets/blind_date_card.dart';
import 'match_screen.dart';

class BlindDateScreen extends StatefulWidget {
  const BlindDateScreen({super.key});

  @override
  State<BlindDateScreen> createState() => _BlindDateScreenState();
}

class _BlindDateScreenState extends State<BlindDateScreen> {
  late List<DateUserModel> _users;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _users = List.from(mockDateUsers)..shuffle();
  }

  void _onLike(DateUserModel user) {
    HapticFeedback.mediumImpact();
    // محاكاة تطابق بنسبة 50%
    if (DateTime.now().millisecond % 2 == 0) {
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

  @override
  Widget build(BuildContext context) {
    return _users.isEmpty
        ? const Center(child: Text('لا يوجد مواعيد مجهولة', style: TextStyle(color: DateColors.text2)))
        : Stack(
            children: List.generate(
              _users.length - _currentIndex > 3 ? 3 : _users.length - _currentIndex,
              (i) {
                final user = _users[_currentIndex + i];
                return Positioned(
                  bottom: i * 10.0,
                  left: 8,
                  right: 8,
                  child: BlindDateCard(
                    user: user,
                    isTop: i == 0,
                    onSwipeRight: () => _onLike(user),
                    onSwipeLeft: () => _onNope(user),
                  ),
                );
              },
            ),
          );
  }
}
