import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ViewerLevelIcon extends StatelessWidget {
  final int level;
  const ViewerLevelIcon({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [LiveColors.gold, LiveColors.accent]),
        shape: BoxShape.circle,
      ),
      child: Text('$level', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}
