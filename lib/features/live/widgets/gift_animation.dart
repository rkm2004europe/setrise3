import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GiftAnimation extends StatefulWidget {
  final String emoji;
  const GiftAnimation({super.key, required this.emoji});

  @override
  State<GiftAnimation> createState() => _GiftAnimationState();
}

class _GiftAnimationState extends State<GiftAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scale = Tween<double>(begin: 0.3, end: 1.8).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _opacity = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.6, 1.0)));
    _ctrl.forward();
    _ctrl.addStatusListener((s) { if (s == AnimationStatus.completed) _ctrl.reset(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(scale: _scale, child: Text(widget.emoji, style: const TextStyle(fontSize: 64))),
    );
  }
}
