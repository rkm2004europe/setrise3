import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/serendipity_model.dart';

class SerendipityCard extends StatelessWidget {
  final SerendipityModel match;
  const SerendipityCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: MapColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        CircleAvatar(backgroundColor: MapColors.accent.withOpacity(0.1), child: Text(match.avatar)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(match.userName, style: const TextStyle(color: MapColors.text, fontWeight: FontWeight.w700)),
          Text('توافق ${match.compatibilityScore}%', style: const TextStyle(color: MapColors.accent)),
        ])),
      ]),
    );
  }
}
