import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/library_controller.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  final LibraryController controller;
  const RecentlyPlayedScreen({super.key, required this.controller});

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
                const Text('Recently Played', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: controller.recentlyPlayed.isEmpty
                  ? const Center(child: Text('No recently played', style: TextStyle(color: MusicColors.text2)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.recentlyPlayed.length,
                      itemBuilder: (_, i) => TrackTile(track: controller.recentlyPlayed[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: controller.recentlyPlayed[i])))),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
