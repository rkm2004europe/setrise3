import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DateMatchAnimation extends StatefulWidget {
  final VoidCallback onComplete;
  const DateMatchAnimation({super.key, required this.onComplete});

  @override
  State<DateMatchAnimation> createState() => _DateMatchAnimationState();
}

class _DateMatchAnimationState extends State<DateMatchAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _scale = Tween<double>(begin: 0.5, end: 1.2).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)));
    _opacity = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.6, 1.0)));
    _ctrl.forward();
    _ctrl.addStatusListener((s) { if (s == AnimationStatus.completed) widget.onComplete(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          color: DateColors.accent.withOpacity(0.3),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('✨', style: TextStyle(fontSize: 80)),
              const SizedBox(height: 16),
              const Text('إنه تطابق!', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
            ]),
          ),
        ),
      ),
    );
  }
}
