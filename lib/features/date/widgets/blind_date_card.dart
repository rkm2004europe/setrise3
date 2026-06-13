import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';

class BlindDateCard extends StatefulWidget {
  final DateUserModel user;
  final bool isTop;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const BlindDateCard({
    super.key,
    required this.user,
    required this.isTop,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  @override
  State<BlindDateCard> createState() => _BlindDateCardState();
}

class _BlindDateCardState extends State<BlindDateCard> with SingleTickerProviderStateMixin {
  double _dragX = 0;
  bool _isDragging = false;
  bool _revealed = false;
  late AnimationController _revealAnim;
  late Animation<double> _revealScale;

  @override
  void initState() {
    super.initState();
    _revealAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _revealScale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _revealAnim, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _revealAnim.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
      _isDragging = true;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final width = MediaQuery.of(context).size.width;
    if (_dragX.abs() > width * 0.3) {
      if (_dragX > 0) {
        widget.onSwipeRight();
        // كشف الصورة بعد الإعجاب
        _reveal();
      } else {
        widget.onSwipeLeft();
      }
    }
    _resetPosition();
  }

  void _reveal() {
    _revealAnim.forward();
    setState(() => _revealed = true);
  }

  void _resetPosition() {
    setState(() {
      _dragX = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return GestureDetector(
      onPanUpdate: widget.isTop ? _onPanUpdate : null,
      onPanEnd: widget.isTop ? _onPanEnd : null,
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Transform.rotate(
          angle: _dragX / 500,
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
                // محتوى مجهول
                if (!_revealed)
                  _buildBlindContent(user)
                else
                  // بعد الكشف: تظهر الصورة
                  ScaleTransition(
                    scale: _revealScale,
                    child: _buildRevealedContent(user),
                  ),
                // مؤشرات السحب
                if (_isDragging) ...[
                  if (_dragX > 60)
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: DateColors.like.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: DateColors.like, width: 2),
                          ),
                          child: const Text(
                            'LIKE',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  if (_dragX < -60)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: DateColors.nope.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: DateColors.nope, width: 2),
                          ),
                          child: const Text(
                            'NOPE',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlindContent(DateUserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // أيقونة مجهول
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: DateColors.accent.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.question_mark, color: DateColors.accent, size: 48),
        ),
        const SizedBox(height: 24),
        const Text(
          'موعد مجهول',
          style: TextStyle(color: DateColors.accent, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          '${user.age} سنة • ${user.distance ?? "قريب"}',
          style: const TextStyle(color: DateColors.text2, fontSize: 16),
        ),
        const SizedBox(height: 20),
        // الاهتمامات
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: user.interests.map((interest) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: DateColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                interest,
                style: const TextStyle(color: DateColors.accent, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          user.bio,
          textAlign: TextAlign.center,
          style: const TextStyle(color: DateColors.text2, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRevealedContent(DateUserModel user) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(user.photos[0], style: const TextStyle(fontSize: 120)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}، ${user.age}',
                style: const TextStyle(color: DateColors.text, fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(user.bio, style: const TextStyle(color: DateColors.text2, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
