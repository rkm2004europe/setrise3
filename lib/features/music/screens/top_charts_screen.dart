import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_tracks.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class TopChartsScreen extends StatelessWidget {
  const TopChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = List.from(mockTracks)..sort((a, b) => b.plays.compareTo(a.plays));
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
                const Text('Top Charts', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sorted.length,
                itemBuilder: (_, i) => TrackTile(track: sorted[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: sorted[i])))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
