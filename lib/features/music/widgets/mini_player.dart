import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';

class MiniPlayer extends StatelessWidget {
  final TrackModel track;
  final VoidCallback onTap;

  const MiniPlayer({super.key, required this.track, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(color: MusicColors.surface, border: Border(top: BorderSide(color: MusicColors.border))),
        child: Row(
          children: [
            Text(track.coverEmoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(track.title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w600)),
                Text(track.artist, style: const TextStyle(color: MusicColors.text2, fontSize: 12)),
              ]),
            ),
            IconButton(icon: const Icon(Icons.play_arrow, color: MusicColors.text), onPressed: onTap),
            IconButton(icon: const Icon(Icons.skip_next, color: MusicColors.text2), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
