import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CollaborativePlaylistScreen extends StatelessWidget {
  const CollaborativePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.group_add, size: 64, color: MusicColors.accent),
            const SizedBox(height: 16),
            const Text('Collaborative Playlist', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Create a playlist others can add to', style: TextStyle(color: MusicColors.text2)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), decoration: BoxDecoration(color: MusicColors.accent, borderRadius: BorderRadius.circular(14)), child: const Text('Create', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
          ]),
        ),
      ),
    );
  }
}
