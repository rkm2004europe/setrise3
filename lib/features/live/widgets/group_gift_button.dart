import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GroupGiftButton extends StatelessWidget {
  final String giftName;
  final int requiredContributors;
  final int currentContributors;
  final VoidCallback onContribute;
  const GroupGiftButton({super.key, required this.giftName, required this.requiredContributors, required this.currentContributors, required this.onContribute});

  @override
  Widget build(BuildContext context) {
    final remaining = requiredContributors - currentContributors;
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Expanded(child: Text('$giftName (${currentContributors}/$requiredContributors)', style: const TextStyle(color: LiveColors.text))),
        GestureDetector(
          onTap: remaining > 0 ? onContribute : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: remaining > 0 ? LiveColors.accent : LiveColors.text2, borderRadius: BorderRadius.circular(12)),
            child: Text(remaining > 0 ? 'ساهم' : 'مكتمل', style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ]),
    );
  }
}
