import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GiveawayWheel extends StatefulWidget {
  final List<String> participants;
  final VoidCallback onSelect;
  const GiveawayWheel({super.key, required this.participants, required this.onSelect});

  @override
  State<GiveawayWheel> createState() => _GiveawayWheelState();
}

class _GiveawayWheelState extends State<GiveawayWheel> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..addListener(() {
      setState(() => _selectedIndex = (_ctrl.value * widget.participants.length).floor() % widget.participants.length);
    });
  }

  void spin() {
    _ctrl.reset();
    _ctrl.forward().then((_) => widget.onSelect());
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: spin,
      child: Container(
        width: 200, height: 200,
        decoration: BoxDecoration(color: LiveColors.gold.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: LiveColors.gold, width: 3)),
        child: Center(child: Text(widget.participants.isEmpty ? '?' : widget.participants[_selectedIndex], style: const TextStyle(color: LiveColors.gold, fontSize: 24))),
      ),
    );
  }
}
