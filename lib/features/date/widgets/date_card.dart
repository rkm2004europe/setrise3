import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import 'swipe_indicator.dart';

class DateCard extends StatefulWidget {
  final DateUserModel user;
  final bool isTop;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final VoidCallback onTap;

  const DateCard({
    super.key,
    required this.user,
    required this.isTop,
    required this.onSwipeRight,
    required this.onSwipeLeft,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onTap,
  });

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> with SingleTickerProviderStateMixin {
  double _dragX = 0, _dragY = 0;
  bool _isDragging = false;
  int _photoIndex = 0;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
      _dragY += details.delta.dy;
      _isDragging = true;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (_dragX.abs() > width * 0.3) {
      if (_dragX > 0) {
        widget.onSwipeRight();
      } else {
        widget.onSwipeLeft();
      }
      _resetPosition();
    } else if (_dragY.abs() > height * 0.15) {
      if (_dragY < 0) {
        // سحب للأعلى = الصورة التالية
        setState(() {
          _photoIndex = (_photoIndex + 1) % widget.user.photos.length;
        });
      } else {
        // سحب للأسفل = الصورة السابقة
        setState(() {
          _photoIndex = (_photoIndex - 1 + widget.user.photos.length) % widget.user.photos.length;
        });
      }
      _resetPosition();
    } else {
      _resetPosition();
    }
  }

  void _resetPosition() {
    setState(() {
      _dragX = 0;
      _dragY = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: widget.isTop ? _onPanUpdate : null,
      onPanEnd: widget.isTop ? _onPanEnd : null,
      child: Transform.translate(
        offset: Offset(_dragX, _dragY),
        child: Transform.rotate(
          angle: _dragX / 500,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: DateColors.surface,
              border: Border.all(color: DateColors.border),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // الصورة الرئيسية
                Center(
                  child: Text(
                    user.photos[_photoIndex],
                    style: TextStyle(fontSize: 120),
                  ),
                ),
                // مؤشرات السحب
                if (_isDragging) ...[
                  if (_dragX > 60)
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: SwipeIndicator(label: 'LIKE', color: DateColors.like),
                      ),
                    ),
                  if (_dragX < -60)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: SwipeIndicator(label: 'NOPE', color: DateColors.nope),
                      ),
                    ),
                ],
                // معلومات أسفل البطاقة
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${user.name}، ${user.age}',
                              style: const TextStyle(
                                color: DateColors.text,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            if (user.isVerified)
                              const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.verified,
                                  color: DateColors.accent,
                                  size: 20,
                                ),
                              ),
                            if (user.isOnline)
                              Container(
                                margin: const EdgeInsets.only(left: 6),
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: DateColors.like,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.bio,
                          style: const TextStyle(
                            color: DateColors.text2,
                            fontSize: 14,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: user.interests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: DateColors.accent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                interest,
                                style: const TextStyle(
                                  color: DateColors.accent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // نقاط التنقل بين الصور
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      user.photos.length,
                      (i) => Container(
                        width: i == _photoIndex ? 20 : 6,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: i == _photoIndex
                              ? DateColors.accent
                              : DateColors.text2.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
