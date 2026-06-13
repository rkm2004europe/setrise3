import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({super.key});

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
                children: List.generate(8, (i) => Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(['💻', '📱', '⌚', '🎧', '📷', '🖨️', '🎮', '📺'][i], style: const TextStyle(fontSize: 48)),
                    const SizedBox(height: 8),
                    Text('جهاز ${i+1}', style: const TextStyle(color: ShopColors.text)),
                    Text('\$${(i+1)*100}', style: const TextStyle(color: ShopColors.accent)),
                  ]),
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
      const Text('الإلكترونيات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
