import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'editor_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // ألوان وهمية لمحاكاة الصور
  final List<Color> _mockMedia = const [
    Color(0xFF1A0A2E), Color(0xFF0A1628), Color(0xFF1A0A0A),
    Color(0xFF0A1A0A), Color(0xFF1A1A0A), Color(0xFF2E0A1A),
    Color(0xFF0A2E2E), Color(0xFF2E1A0A), Color(0xFF001A2E),
    Color(0xFF3A1A2E), Color(0xFF1A3A2E), Color(0xFF2E2E1A),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      color: PostColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  // Camera quick access
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // العودة للهب لفتح الكاميرا
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: PostColors.accent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: PostColors.accent, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: PostColors.textSecondary),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: _mockMedia.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // الانتقال إلى المحرر مع الصورة/الفيديو المختار
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditorScreen(
                            mediaPath: 'gallery_image_$index.jpg',
                            isVideo: index % 3 == 0, // بعضها فيديو
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: _mockMedia[index],
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.white.withOpacity(0.3),
                              size: 32,
                            ),
                          ),
                          if (index % 3 == 0)
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white, size: 14),
                                    SizedBox(width: 2),
                                    Text('0:15', style: TextStyle(color: Colors.white, fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
