import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatStatistics extends StatelessWidget {
  final int totalMessages, mediaCount, linksCount;

  const ChatStatistics({super.key, required this.totalMessages, required this.mediaCount, required this.linksCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Stat(label: 'الرسائل', value: totalMessages.toString()),
          _Stat(label: 'الوسائط', value: mediaCount.toString()),
          _Stat(label: 'الروابط', value: linksCount.toString()),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: ChatColors.text, fontWeight: FontWeight.w900, fontSize: 18)),
    Text(label, style: const TextStyle(color: ChatColors.text2, fontSize: 11)),
  ]);
}
