import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';

class SpeedDateCard extends StatefulWidget {
  final DateUserModel user;
  final int timeLeft; // الثواني المتبقية
  final bool isTop;
  final VoidCallback onLike;
  final VoidCallback onNope;
  final VoidCallback onTimeout;

  const SpeedDateCard({
    super.key,
    required this.user,
    required this.timeLeft,
    required this.isTop,
    required this.onLike,
    required this.onNope,
    required this.onTimeout,
  });

  @override
  State<SpeedDateCard> createState() => _SpeedDateCardState();
}

class _SpeedDateCardState extends State<SpeedDateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerAnim;
  double _dragX = 0;

  @override
  void initState() {
    super.initState();
    _timerAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // المدة الكلية
    );
    // مراقبة انتهاء الوقت
    _timerAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onTimeout();
      }
    });
    _timerAnim.forward();
  }

  @override
  void dispose() {
    _timerAnim.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final width = MediaQuery.of(context).size.width;
    if (_dragX.abs() > width * 0.25) {
      if (_dragX > 0) {
        widget.onLike();
      } else {
        widget.onNope();
      }
    }
    setState(() => _dragX = 0);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final progress = 1.0 - (_timerAnim.value);

    return GestureDetector(
      onPanUpdate: widget.isTop ? _onPanUpdate : null,
      onPanEnd: widget.isTop ? _onPanEnd : null,
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: DateColors.surface,
            border: Border.all(color: DateColors.border),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // صورة كبيرة
              Center(
                child: Text(user.photos[0], style: const TextStyle(fontSize: 120)),
              ),
              // مؤقت في الأعلى
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: AnimatedBuilder(
                  animation: _timerAnim,
                  builder: (_, __) => Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: DateColors.text2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: progress < 0.2
                              ? DateColors.nope
                              : DateColors.accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // معلومات أسفل
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
                      Text(
                        '${user.name}، ${user.age}',
                        style: const TextStyle(
                          color: DateColors.text,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.bio,
                        style: const TextStyle(
                          color: DateColors.text2,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        children: user.interests.map((i) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: DateColors.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              i,
                              style: const TextStyle(
                                color: DateColors.accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '⏱ ${widget.timeLeft} ثانية',
                        style: const TextStyle(
                          color: DateColors.text2,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // أزرار سريعة
              Positioned(
                bottom: 100,
                right: 16,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: widget.onLike,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: DateColors.like,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: DateColors.like.withOpacity(0.5),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 28),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: widget.onNope,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: DateColors.nope,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: DateColors.nope.withOpacity(0.5),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
