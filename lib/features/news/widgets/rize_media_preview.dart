import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeMediaPreview extends StatelessWidget {
  final String mediaUrl;
  final bool isVideo;
  final VoidCallback onTap;

  const RizeMediaPreview({
    super.key,
    required this.mediaUrl,
    this.isVideo = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: NewsColors.surface,
            border: Border.all(color: NewsColors.border),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                mediaUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.broken_image, color: NewsColors.textSecondary, size: 48),
                ),
              ),
              if (isVideo)
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
