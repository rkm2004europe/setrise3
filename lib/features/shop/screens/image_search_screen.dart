import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ImageSearchScreen extends StatelessWidget {
  const ImageSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 120, height: 120,
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.image_search, size: 64, color: ShopColors.accent),
              ),
            ),
            const SizedBox(height: 20),
            const Text('ارفع صورة للبحث عن منتج مشابه', style: TextStyle(color: ShopColors.text2)),
          ]),
        ),
      ),
    );
  }
}
