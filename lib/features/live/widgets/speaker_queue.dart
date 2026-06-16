import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpeakerQueue extends StatelessWidget {
  final List<String> queue;
  final Function(String) onAccept;
  const SpeakerQueue({super.key, required this.queue, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    if (queue.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('قائمة الانتظار', style: TextStyle(color: LiveColors.text2, fontSize: 12)),
        ...queue.map((id) => ListTile(title: Text(id), trailing: GestureDetector(onTap: () => onAccept(id), child: const Icon(Icons.check, color: LiveColors.accent)))),
      ]),
    );
  }
}
