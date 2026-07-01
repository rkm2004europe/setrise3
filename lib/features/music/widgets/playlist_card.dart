import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;
  final VoidCallback onTap;

  const PlaylistCard({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Text(playlist.coverEmoji, style: const TextStyle(fontSize: 48))),
          const SizedBox(height: 10),
          Text(playlist.name, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w700, fontSize: 14)),
          Text('${playlist.trackCount} أغنية', style: const TextStyle(color: MusicColors.text2, fontSize: 12)),
        ]),
      ),
    );
  }
}
