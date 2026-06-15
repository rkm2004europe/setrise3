import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PhotoReviewsScreen extends StatelessWidget {
  final String productId;
  const PhotoReviewsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(4),
                children: List.generate(9, (i) => Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text(['📸','🖼️','🌅','📷','🎞️','🏞️','📹','🎥','📽️'][i], style: const TextStyle(fontSize: 28))),
                )),
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
      const Text('تقييمات بالصور', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
