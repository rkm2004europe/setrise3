import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LivePulseMarker extends StatefulWidget {
  const LivePulseMarker({super.key});

  @override
  State<LivePulseMarker> createState() => _LivePulseMarkerState();
}

class _LivePulseMarkerState extends State<LivePulseMarker> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.8, end: 1.5).animate(_ctrl);
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
          width: 24, height: 24,
          decoration: BoxDecoration(color: MapColors.red.withOpacity(0.4), shape: BoxShape.circle),
          child: const Icon(Icons.live_tv, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}
