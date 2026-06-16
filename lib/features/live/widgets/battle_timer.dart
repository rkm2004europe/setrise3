import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BattleTimer extends StatefulWidget {
  final int totalSeconds;
  final VoidCallback onEnd;
  const BattleTimer({super.key, required this.totalSeconds, required this.onEnd});

  @override
  State<BattleTimer> createState() => _BattleTimerState();
}

class _BattleTimerState extends State<BattleTimer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late int _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.totalSeconds;
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: widget.totalSeconds))
      ..addListener(() {
        setState(() => _remaining = (widget.totalSeconds * (1 - _ctrl.value)).ceil());
        if (_ctrl.isCompleted) widget.onEnd();
      })
      ..forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${(_remaining ~/ 60).toString().padLeft(2, '0')}:${(_remaining % 60).toString().padLeft(2, '0')}',
      style: const TextStyle(color: LiveColors.gold, fontSize: 28, fontWeight: FontWeight.w900),
    );
  }
}
