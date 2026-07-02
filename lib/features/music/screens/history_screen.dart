import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_tracks.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                const Text('Listening History', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockTracks.length,
                itemBuilder: (_, i) => TrackTile(track: mockTracks[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: mockTracks[i])))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
