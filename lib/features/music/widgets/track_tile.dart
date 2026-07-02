import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../controllers/library_controller.dart';
import '../../user/screens/user_preview_sheet.dart';

class TrackTile extends StatelessWidget {
  final TrackModel track;
  final VoidCallback onTap;
  final LibraryController? libraryController;
  final bool showRemoveButton;

  const TrackTile({
    super.key,
    required this.track,
    required this.onTap,
    this.libraryController,
    this.showRemoveButton = false,
  });

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
            if (showRemoveButton && libraryController != null)
              GestureDetector(
                onTap: () => libraryController!.removeLiked(track.id),
                child: const Icon(Icons.close, color: MusicColors.text2, size: 18),
              ),
            if (!showRemoveButton)
              Text('${track.duration.inMinutes}:${(track.duration.inSeconds % 60).toString().padLeft(2, '0')}', style: const TextStyle(color: MusicColors.text2, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
