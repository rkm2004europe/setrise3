import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AddVideoReviewScreen extends StatelessWidget {
  const AddVideoReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const Spacer(),
              const Icon(Icons.videocam, size: 80, color: ShopColors.accent),
              const SizedBox(height: 16),
              const Text('سجل فيديو لتقييم المنتج', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: ShopColors.accent, shape: BoxShape.circle),
                  child: const Icon(Icons.fiber_manual_record, color: Colors.red, size: 32),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('تقييم بالفيديو', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
