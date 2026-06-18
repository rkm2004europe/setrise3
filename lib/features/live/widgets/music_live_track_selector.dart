import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MusicLiveTrackSelector extends StatelessWidget {
  final Function(String title) onTrackSelected;
  const MusicLiveTrackSelector({super.key, required this.onTrackSelected});

  final List<Map<String, String>> tracks = const [
    {'title': 'Epic Beat', 'artist': 'Producer X', 'emoji': '🎵'},
    {'title': 'Chill Vibes', 'artist': 'LoFi Studio', 'emoji': '🎧'},
    {'title': 'Trap Energy', 'artist': 'BeatMaster', 'emoji': '🎹'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('اختر موسيقى', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...tracks.map((t) => ListTile(
          leading: Text(t['emoji']!, style: const TextStyle(fontSize: 24)),
          title: Text(t['title']!, style: const TextStyle(color: LiveColors.text)),
          subtitle: Text(t['artist']!, style: const TextStyle(color: LiveColors.text2)),
          onTap: () => onTrackSelected(t['title']!),
        )),
      ]),
    );
  }
}
