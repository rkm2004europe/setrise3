import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DigitalSoulMarker extends StatelessWidget {
  final String name;
  final String mood;
  const DigitalSoulMarker({super.key, required this.name, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: MapColors.accent.withOpacity(0.2), shape: BoxShape.circle),
      child: const Icon(Icons.person, color: MapColors.accent, size: 18),
    );
  }
}
