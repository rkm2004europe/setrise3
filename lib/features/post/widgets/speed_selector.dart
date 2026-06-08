import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpeedSelector extends StatelessWidget {
  final double selectedSpeed;
  final ValueChanged<double> onSpeedChanged;

  const SpeedSelector({super.key, required this.selectedSpeed, required this.onSpeedChanged});

  @override
  Widget build(BuildContext context) {
    final speeds = [0.5, 1.0, 1.5, 2.0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: speeds.map((speed) {
        final selected = selectedSpeed == speed;
        return GestureDetector(
          onTap: () => onSpeedChanged(speed),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? PostColors.accent : Colors.white10,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? PostColors.accent : Colors.white24),
            ),
            child: Text('${speed}x', style: TextStyle(color: selected ? Colors.white : Colors.white70, fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }
}
