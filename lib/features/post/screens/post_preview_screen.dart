import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PostPreviewScreen extends StatelessWidget {
  final String mediaPath;
  final bool isVideo;
  final String caption;
  final String username;

  const PostPreviewScreen({
    super.key,
    required this.mediaPath,
    required this.isVideo,
    required this.caption,
    this.username = '@you',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Media background (simulated)
          Center(
            child: Container(
              color: Colors.white10,
              child: Center(
                child: Icon(
                  isVideo ? Icons.play_circle : Icons.image,
                  color: Colors.white54,
                  size: 64,
                ),
              ),
            ),
          ),

          // Overlay elements (simulating the feed look)
          Positioned(
            bottom: 100,
            left: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  caption,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons (right side)
          Positioned(
            right: 12,
            bottom: 100,
            child: Column(
              children: [
                _buildAction(Icons.favorite_border, 'Like'),
                const SizedBox(height: 16),
                _buildAction(Icons.chat_bubble_outline, 'Comment'),
                const SizedBox(height: 16),
                _buildAction(Icons.send, 'Share'),
              ],
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                  const Spacer(),
                  const Text(
                    'Preview',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }
}
