import 'package:flutter/material.dart';
import '../theme/colors.dart';

class TypingIndicator extends StatefulWidget {
  final String userName;
  const TypingIndicator({super.key, required this.userName});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _ctrl,
            builder: (_, child) => Row(
              children: [
                _Dot(delay: 0, anim: _ctrl),
                const SizedBox(width: 3),
                _Dot(delay: 0.2, anim: _ctrl),
                const SizedBox(width: 3),
                _Dot(delay: 0.4, anim: _ctrl),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(widget.userName, style: const TextStyle(color: ChatColors.text2, fontSize: 12)),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double delay;
  final Animation<double> anim;
  const _Dot({required this.delay, required this.anim});

  @override
  Widget build(BuildContext context) {
    final val = ((anim.value - delay) % 1.0).clamp(0.0, 1.0);
    final size = 6.0 + val * 2;
    return Container(width: size, height: size, decoration: BoxDecoration(color: ChatColors.text2, shape: BoxShape.circle));
  }
}
