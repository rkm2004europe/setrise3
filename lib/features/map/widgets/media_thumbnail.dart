import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MediaThumbnail extends StatelessWidget {
  final String imageEmoji;
  final VoidCallback onTap;
  const MediaThumbnail({super.key, required this.imageEmoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: MapColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MapColors.accent),
        ),
        child: Center(child: Text(imageEmoji, style: const TextStyle(fontSize: 24))),
      ),
    );
  }
}
