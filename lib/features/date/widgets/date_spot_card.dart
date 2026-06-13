import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/date_spot_model.dart';

class DateSpotCard extends StatelessWidget {
  final DateSpotModel spot;
  final VoidCallback onTap;
  const DateSpotCard({super.key, required this.spot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Text(spot.imageEmoji, style: const TextStyle(fontSize: 40))),
          const SizedBox(height: 8),
          Text(spot.name, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w700)),
          Text(spot.type, style: const TextStyle(color: DateColors.text2, fontSize: 12)),
          Row(children: [const Icon(Icons.star, color: Colors.amber, size: 12), Text(' ${spot.rating}', style: const TextStyle(color: DateColors.text2, fontSize: 12))]),
        ]),
      ),
    );
  }
}
