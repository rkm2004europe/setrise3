import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class QnaCard extends StatelessWidget {
  final String question, answer;
  const QnaCard({super.key, required this.question, required this.answer});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(question, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Text(answer, style: const TextStyle(color: ShopColors.text2)),
    ]),
  );
}
