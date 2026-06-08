import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeHashtagChip extends StatelessWidget {
  final String hashtag;
  final VoidCallback onTap;

  const RizeHashtagChip({super.key, required this.hashtag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: NewsColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: NewsColors.accent.withOpacity(0.3)),
        ),
        child: Text('#$hashtag', style: const TextStyle(color: NewsColors.accent, fontSize: 12)),
      ),
    );
  }
}
