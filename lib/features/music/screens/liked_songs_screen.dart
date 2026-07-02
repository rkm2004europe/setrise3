import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/library_controller.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class LikedSongsScreen extends StatelessWidget {
  final LibraryController controller;
  const LikedSongsScreen({super.key, required this.controller});

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
                const Text('Liked Songs', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: controller.likedSongs.isEmpty
                  ? const Center(child: Text('No liked songs', style: TextStyle(color: MusicColors.text2)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.likedSongs.length,
                      itemBuilder: (_, i) => TrackTile(
                        track: controller.likedSongs[i],
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: controller.likedSongs[i]))),
                        libraryController: controller,
                        showRemoveButton: true,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
