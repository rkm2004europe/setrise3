import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/album_model.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class AlbumScreen extends StatelessWidget {
  final AlbumModel album;
  const AlbumScreen({super.key, required this.album});

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
                Text(album.title, style: const TextStyle(color: MusicColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(child: Text(album.coverEmoji, style: const TextStyle(fontSize: 100))),
                  const SizedBox(height: 16),
                  Text('${album.artist} • ${album.year}', style: const TextStyle(color: MusicColors.text2, fontSize: 14), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ...album.tracks.map((t) => TrackTile(track: t, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: t))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
