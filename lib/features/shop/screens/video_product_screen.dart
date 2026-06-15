import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class VideoProductScreen extends StatelessWidget {
  final String productName;
  final String videoUrl;
  const VideoProductScreen({super.key, required this.productName, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Container(
                color: ShopColors.surface,
                child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.play_circle_fill, color: ShopColors.accent, size: 80),
                    const SizedBox(height: 16),
                    Text(productName, style: const TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text('اضغط للتشغيل', style: TextStyle(color: ShopColors.text2)),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      Text(productName, style: const TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
