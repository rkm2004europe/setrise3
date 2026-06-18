import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WallOfFameScreen extends StatelessWidget {
  const WallOfFameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                children: List.generate(9, (i) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(radius: 30, backgroundColor: LiveColors.gold.withOpacity(0.2), child: const Icon(Icons.star, color: LiveColors.gold)),
                  const SizedBox(height: 6),
                  Text('نجم ${i+1}', style: const TextStyle(color: LiveColors.text, fontSize: 12)),
                ])),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('جدار الشرف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
