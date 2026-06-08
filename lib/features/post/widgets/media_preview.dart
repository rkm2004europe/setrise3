import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MediaPreview extends StatelessWidget {
  final String mediaPath;
  final bool isVideo;

  const MediaPreview({super.key, required this.mediaPath, required this.isVideo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 200,
      decoration: BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder for actual image/video
            const Center(child: Icon(Icons.image, color: PostColors.textSecondary, size: 48)),
            if (isVideo)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('0:30', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
