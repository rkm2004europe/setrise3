import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_albums.dart';
import '../widgets/album_card.dart';
import 'album_screen.dart';

class AlbumOfWeekScreen extends StatelessWidget {
  const AlbumOfWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final album = mockAlbums.first;
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
                const Text('Album of the Week', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: Center(
                child: AlbumCard(album: album, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumScreen(album: album)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
