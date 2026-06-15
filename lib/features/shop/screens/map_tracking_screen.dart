import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MapTrackingScreen extends StatelessWidget {
  const MapTrackingScreen({super.key});

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
                child: const Center(child: Icon(Icons.map, size: 120, color: ShopColors.accent)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: ShopColors.surface, border: Border(top: BorderSide(color: ShopColors.border))),
              child: const Row(children: [
                Icon(Icons.local_shipping, color: ShopColors.accent),
                SizedBox(width: 10),
                Text('في الطريق...', style: TextStyle(color: ShopColors.text)),
                Spacer(),
                Text('2 كم متبقي', style: TextStyle(color: ShopColors.text2)),
              ]),
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
      const Text('تتبع على الخريطة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
