import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_history_model.dart';

class LiveHistoryCard extends StatelessWidget {
  final LiveHistoryModel history;
  const LiveHistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(history.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700)),
          Text('${history.viewers} مشاهد • ${history.gifts} هدية', style: const TextStyle(color: LiveColors.text2)),
        ])),
        Text('\$${history.earnings.toStringAsFixed(2)}', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}
