import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HotspotPulse extends StatefulWidget {
  final Color color;
  const HotspotPulse({super.key, required this.color});

  @override
  State<HotspotPulse> createState() => _HotspotPulseState();
}

class _HotspotPulseState extends State<HotspotPulse> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.5, end: 1.2).animate(_ctrl);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Transform.scale(
        scale: _anim.value,
        child: Container(
          width: 20, height: 20,
          decoration: BoxDecoration(color: widget.color.withOpacity(0.3), shape: BoxShape.circle),
        ),
      ),
    );
  }
}
