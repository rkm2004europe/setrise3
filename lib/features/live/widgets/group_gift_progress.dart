import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/group_gift_model.dart';

class GroupGiftProgress extends StatelessWidget {
  final GroupGiftModel gift;
  const GroupGiftProgress({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(gift.giftName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: LinearProgressIndicator(value: gift.currentContributors / gift.requiredContributors, color: LiveColors.gold)),
          const SizedBox(width: 10),
          Text('${gift.currentContributors}/${gift.requiredContributors}', style: const TextStyle(color: LiveColors.text2)),
        ]),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
            child: const Text('ساهم', style: TextStyle(color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
