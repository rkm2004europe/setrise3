import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../../shar/screens/share_sheet.dart';

class ShareMusicButton extends StatelessWidget {
  final TrackModel track;
  const ShareMusicButton({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ShareSheet.show(context, data: ShareData(
        id: track.id, title: track.title, subtitle: track.artist, accentColor: MusicColors.accent,
      )),
      child: const Icon(Icons.ios_share, color: MusicColors.text, size: 22),
    );
  }
}
