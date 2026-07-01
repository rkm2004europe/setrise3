import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';

class MusicQueueSheet extends StatelessWidget {
  final List<TrackModel> queue;
  const MusicQueueSheet({super.key, required this.queue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Text('قائمة الانتظار', style: TextStyle(color: MusicColors.text, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          if (queue.isEmpty) const Text('لا توجد أغاني في الانتظار', style: TextStyle(color: MusicColors.text2)),
          ...queue.map((t) => ListTile(
            leading: Text(t.coverEmoji, style: const TextStyle(fontSize: 24)),
            title: Text(t.title, style: const TextStyle(color: MusicColors.text)),
            subtitle: Text(t.artist, style: const TextStyle(color: MusicColors.text2)),
          )),
        ],
      ),
    );
  }
}
