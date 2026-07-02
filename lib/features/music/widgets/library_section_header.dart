import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LibrarySectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const LibrarySectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        Text(title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
        const Spacer(),
        if (onSeeAll != null) GestureDetector(onTap: onSeeAll, child: const Text('See All', style: TextStyle(color: MusicColors.accent, fontSize: 13))),
      ]),
    );
  }
}
