import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MapLiveTourWidget extends StatelessWidget {
  const MapLiveTourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        const Icon(Icons.map, color: LiveColors.accent),
        const SizedBox(width: 8),
        const Text('جولة حية على الخريطة', style: TextStyle(color: LiveColors.text)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.play_arrow, color: LiveColors.accent),
        ),
      ]),
    );
  }
}
