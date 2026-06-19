import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/gift_model.dart';
import '../data/mock_gifts.dart';

class GiftCollectionScreen extends StatelessWidget {
  const GiftCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: mockGifts.length,
                itemBuilder: (_, i) {
                  final gift = mockGifts[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: LiveColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: LiveColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gift.animationEmoji, style: const TextStyle(fontSize: 36)),
                        const SizedBox(height: 8),
                        Text(gift.name, style: const TextStyle(color: LiveColors.text, fontSize: 12)),
                        Text('${gift.coinValue} 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 11)),
                      ],
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

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('مجموعة الهدايا', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
