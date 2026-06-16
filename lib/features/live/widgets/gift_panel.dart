import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/gift_model.dart';

class GiftPanel extends StatelessWidget {
  final List<GiftModel> gifts;
  final Function(GiftModel) onSend;
  final VoidCallback onClose;

  const GiftPanel({super.key, required this.gifts, required this.onSend, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: LiveColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('الهدايا', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
              const Spacer(),
              GestureDetector(onTap: onClose, child: const Icon(Icons.close, color: LiveColors.text2)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: gifts.map((gift) => GestureDetector(
              onTap: () => onSend(gift),
              child: Container(
                decoration: BoxDecoration(
                  color: LiveColors.bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: LiveColors.border),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(gift.animationEmoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 4),
                  Text(gift.name, style: const TextStyle(color: LiveColors.text, fontSize: 10)),
                  Text('${gift.coinValue} 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 10)),
                ]),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
