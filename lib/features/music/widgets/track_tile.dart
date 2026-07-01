import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class TrackTile extends StatelessWidget {
  final TrackModel track;
  final VoidCallback onTap;

  const TrackTile({super.key, required this.track, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MusicColors.border.withOpacity(0.3)))),
        child: Row(
          children: [
            Text(track.coverEmoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(track.title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () => showUserPreviewSheet(context, userId: track.artist, userName: track.artist, username: '@${track.artist}', accent: MusicColors.accent),
                  child: Text(track.artist, style: const TextStyle(color: MusicColors.accent, fontSize: 13)),
                ),
              ]),
            ),
            Text('${track.duration.inMinutes}:${(track.duration.inSeconds % 60).toString().padLeft(2, '0')}', style: const TextStyle(color: MusicColors.text2, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
