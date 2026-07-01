import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/artist_model.dart';
import '../data/mock_tracks.dart';

class ArtistScreen extends StatelessWidget {
  final ArtistModel artist;
  const ArtistScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final tracks = mockTracks.where((t) => t.artist == artist.name).toList();

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
                Text(artist.name, style: const TextStyle(color: MusicColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(child: CircleAvatar(radius: 60, backgroundColor: MusicColors.accent.withOpacity(0.1), child: Text(artist.avatarEmoji, style: const TextStyle(fontSize: 48)))),
                  const SizedBox(height: 12),
                  Text('${artist.monthlyListeners ~/ 1000000}M مستمع شهري', style: const TextStyle(color: MusicColors.text2, fontSize: 14), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ...tracks.map((t) => ListTile(
                    leading: Text(t.coverEmoji, style: const TextStyle(fontSize: 28)),
                    title: Text(t.title, style: const TextStyle(color: MusicColors.text)),
                    onTap: () {},
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
