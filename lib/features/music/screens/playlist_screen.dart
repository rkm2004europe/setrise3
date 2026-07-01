import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/playlist_model.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class PlaylistScreen extends StatelessWidget {
  final PlaylistModel playlist;
  const PlaylistScreen({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MusicColors.text)),
                const SizedBox(width: 12),
                Text(playlist.name, style: const TextStyle(color: MusicColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(child: Text(playlist.coverEmoji, style: const TextStyle(fontSize: 80))),
                  const SizedBox(height: 8),
                  Text('${playlist.trackCount} أغنية', style: const TextStyle(color: MusicColors.text2, fontSize: 14), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ...playlist.tracks.map((t) => TrackTile(track: t, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: t))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
