import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime targetTime;
  const CountdownWidget({super.key, required this.targetTime});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = widget.targetTime.difference(DateTime.now()).inSeconds.clamp(0, 99999);
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: _seconds));
    _ctrl.addListener(() => setState(() => _seconds = (widget.targetTime.difference(DateTime.now()).inSeconds.clamp(0, 99999))));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return Text('${h.toString().padLeft(2,'0')}:${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}',
        style: const TextStyle(color: LiveColors.accent, fontSize: 48, fontWeight: FontWeight.w900));
  }
}
