import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TrimBar extends StatelessWidget {
  final double startTrim;
  final double endTrim;
  final ValueChanged<double> onStartChanged;
  final ValueChanged<double> onEndChanged;

  const TrimBar({
    super.key,
    required this.startTrim,
    required this.endTrim,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Start: ${startTrim.toStringAsFixed(1)}s', style: const TextStyle(color: PostColors.textSecondary)),
            const Spacer(),
            Text('End: ${endTrim.toStringAsFixed(1)}s', style: const TextStyle(color: PostColors.textSecondary)),
          ],
        ),
        RangeSlider(
          values: RangeValues(startTrim, endTrim),
          min: 0.0,
          max: 60.0, // video length
          activeColor: PostColors.accent,
          inactiveColor: Colors.white24,
          onChanged: (values) {
            onStartChanged(values.start);
            onEndChanged(values.end);
          },
        ),
      ],
    );
  }
}
