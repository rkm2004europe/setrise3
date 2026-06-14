import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RecentlyViewedScreen extends StatelessWidget {
  const RecentlyViewedScreen({super.key});

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
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: List.generate(4, (i) => Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text('📱', style: TextStyle(fontSize: 32))),
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
      const Text('شوهد مؤخرًا', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
