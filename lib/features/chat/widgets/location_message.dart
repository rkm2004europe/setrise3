import 'package:flutter/material.dart';
import '../theme/colors.dart';

class LocationMessage extends StatelessWidget {
  final String locationName;
  const LocationMessage({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(color: ChatColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, color: ChatColors.accent, size: 36),
          const SizedBox(height: 8),
          Text(locationName, style: const TextStyle(color: ChatColors.text, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
