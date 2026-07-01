import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_playlists.dart';
import '../data/mock_albums.dart';
import '../data/mock_artists.dart';
import '../widgets/playlist_card.dart';
import '../widgets/album_card.dart';
import '../widgets/artist_card.dart';
import 'playlist_screen.dart';
import 'album_screen.dart';
import 'artist_screen.dart';
import 'create_playlist_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: MusicColors.text),
                  ),
                  const SizedBox(width: 12),
                  const Text('My Library', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePlaylistScreen())),
                    child: const Icon(Icons.add, color: MusicColors.accent, size: 28),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: MusicColors.accent,
                      unselectedLabelColor: MusicColors.text2,
                      indicatorColor: MusicColors.accent,
                      tabs: [
                        Tab(text: 'قوائم التشغيل'),
                        Tab(text: 'ألبومات'),
                        Tab(text: 'فنانين'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // قوائم التشغيل
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: mockPlaylists.map((pl) => ListTile(
                              leading: Text(pl.coverEmoji, style: const TextStyle(fontSize: 28)),
                              title: Text(pl.name, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w600)),
                              subtitle: Text('${pl.trackCount} أغنية', style: const TextStyle(color: MusicColors.text2)),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlaylistScreen(playlist: pl))),
                            )).toList(),
                          ),
                          // ألبومات
                          GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
                            ),
                            itemCount: mockAlbums.length,
                            itemBuilder: (_, i) => AlbumCard(album: mockAlbums[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumScreen(album: mockAlbums[i])))),
                          ),
                          // فنانين
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: mockArtists.map((a) => ArtistCard(artist: a, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArtistScreen(artist: a))))).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
