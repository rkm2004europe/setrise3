import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_playlists.dart';
import '../data/mock_albums.dart';
import '../data/mock_artists.dart';
import '../data/mock_tracks.dart';
import '../widgets/playlist_card.dart';
import '../widgets/album_card.dart';
import '../widgets/artist_card.dart';
import '../widgets/track_tile.dart';
import 'playlist_screen.dart';
import 'album_screen.dart';
import 'artist_screen.dart';
import 'create_playlist_screen.dart';
import 'now_playing_screen.dart';
import 'liked_songs_screen.dart';
import 'history_screen.dart';
import 'downloads_screen.dart';
import 'followed_artists_screen.dart';
import '../controllers/library_controller.dart';

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
            // أقسام سريعة
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildQuickSection(context, 'Liked', Icons.favorite, MusicColors.like, () => Navigator.push(context, MaterialPageRoute(builder: (_) => LikedSongsScreen(controller: LibraryController())))),
                  const SizedBox(width: 12),
                  _buildQuickSection(context, 'History', Icons.history, MusicColors.accent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()))),
                  const SizedBox(width: 12),
                  _buildQuickSection(context, 'Downloads', Icons.download, MusicColors.text2, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DownloadsScreen()))),
                  const SizedBox(width: 12),
                  _buildQuickSection(context, 'Artists', Icons.people, MusicColors.accent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FollowedArtistsScreen()))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: MusicColors.accent,
                      unselectedLabelColor: MusicColors.text2,
                      indicatorColor: MusicColors.accent,
                      tabs: [
                        Tab(text: 'Recently'),
                        Tab(text: 'Playlists'),
                        Tab(text: 'Albums'),
                        Tab(text: 'Artists'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Recently Played
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: mockTracks.take(5).map((t) => TrackTile(track: t, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: t))))).toList(),
                          ),
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
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9),
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

  Widget _buildQuickSection(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
      ),
    );
  }
}
