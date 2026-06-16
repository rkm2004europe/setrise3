import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FloatingHearts extends StatefulWidget {
  final bool show;
  const FloatingHearts({super.key, required this.show});

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts> with SingleTickerProviderStateMixin {
  final List<_FloatingHeart> _hearts = [];
  final Random _random = Random();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          for (final h in _hearts) {
            h.offset -= const Offset(0, 3);
            h.opacity -= 0.008;
          }
          _hearts.removeWhere((h) => h.opacity <= 0);
        });
      })
    ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addHeart() {
    if (!widget.show) return;
    final startX = _random.nextDouble() * 200 + 50;
    final size = _random.nextDouble() * 20 + 20;
    _hearts.add(_FloatingHeart(
      offset: Offset(startX, 400),
      size: size,
      opacity: 1.0,
    ));
  }

  @override
  void didUpdateWidget(covariant FloatingHearts oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      // أضف 5 قلوب دفعة واحدة عند التفعيل
      for (int i = 0; i < 5; i++) {
        _addHeart();
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _addHeart();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          children: _hearts.map((h) {
            return Positioned(
              bottom: h.offset.dy,
              left: h.offset.dx,
              child: Opacity(
                opacity: h.opacity.clamp(0.0, 1.0),
                child: Icon(
                  Icons.favorite,
                  color: LiveColors.accent,
                  size: h.size,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FloatingHeart {
  Offset offset;
  double size;
  double opacity;

  _FloatingHeart({
    required this.offset,
    required this.size,
    required this.opacity,
  });
}
