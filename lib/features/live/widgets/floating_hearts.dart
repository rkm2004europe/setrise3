import 'dart:math';
import 'package:flutter/material.dart';

class FloatingHearts extends StatefulWidget {
  final bool trigger;
  final VoidCallback onComplete;

  const FloatingHearts({
    super.key,
    required this.trigger,
    required this.onComplete,
  });

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts> with SingleTickerProviderStateMixin {
  final List<_HeartParticle> _particles = [];
  final Random _random = Random();

  @override
  void didUpdateWidget(FloatingHearts oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _burstHearts();
    }
  }

  void _burstHearts() {
    for (int i = 0; i < 15; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800 + _random.nextInt(600)),
      );

      final startX = (_random.nextDouble() - 0.5) * 100;
      final startY = (_random.nextDouble() - 0.5) * 100;
      final endX = (_random.nextDouble() - 0.5) * 300;
      final endY = -200 - _random.nextDouble() * 300;

      final positionAnim = Tween<Offset>(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

      final scaleAnim = Tween<double>(begin: 1.2, end: 0.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

      final opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0)));

      final particle = _HeartParticle(
        controller: controller,
        position: positionAnim,
        scale: scaleAnim,
        opacity: opacityAnim,
        color: [
          Colors.red,
          Colors.pink,
          Colors.pinkAccent,
          Colors.redAccent,
          Colors.deepOrange,
        ][_random.nextInt(5)],
      );

      _particles.add(particle);

      controller.forward().then((_) {
        if (mounted) {
          setState(() => _particles.remove(particle));
          controller.dispose();
          if (_particles.isEmpty) widget.onComplete();
        }
      });
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (final p in _particles) {
      p.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _particles.map((p) {
        return AnimatedBuilder(
          animation: p.controller,
          builder: (_, child) {
            return Positioned(
              left: MediaQuery.of(context).size.width / 2 + p.position.value.dx - 20,
              top: MediaQuery.of(context).size.height * 0.4 + p.position.value.dy - 20,
              child: Opacity(
                opacity: p.opacity.value,
                child: Transform.scale(
                  scale: p.scale.value,
                  child: child,
                ),
              ),
            );
          },
          child: Icon(Icons.favorite, color: p.color, size: 24),
        );
      }).toList(),
    );
  }
}

class _HeartParticle {
  final AnimationController controller;
  final Animation<Offset> position;
  final Animation<double> scale;
  final Animation<double> opacity;
  final Color color;

  _HeartParticle({
    required this.controller,
    required this.position,
    required this.scale,
    required this.opacity,
    required this.color,
  });
}
