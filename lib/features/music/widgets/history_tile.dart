import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';

class HistoryTile extends StatelessWidget {
  final TrackModel track;
  final VoidCallback onTap;

  const HistoryTile({super.key, required this.track, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(track.coverEmoji, style: const TextStyle(fontSize: 24)),
      title: Text(track.title, style: const TextStyle(color: MusicColors.text)),
      subtitle: Text(track.artist, style: const TextStyle(color: MusicColors.text2)),
      onTap: onTap,
    );
  }
}
