import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ModeratorTools extends StatelessWidget {
  const ModeratorTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        ListTile(leading: const Icon(Icons.block, color: Colors.red), title: const Text('حظر', style: TextStyle(color: LiveColors.text)), onTap: () {}),
        ListTile(leading: const Icon(Icons.mic_off, color: LiveColors.text2), title: const Text('كتم', style: TextStyle(color: LiveColors.text)), onTap: () {}),
        ListTile(leading: const Icon(Icons.flag, color: Colors.orange), title: const Text('إبلاغ', style: TextStyle(color: LiveColors.text)), onTap: () {}),
      ]),
    );
  }
}
