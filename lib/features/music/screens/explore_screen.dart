import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chips.dart';
import '../widgets/album_card.dart';
import '../widgets/artist_card.dart';
import '../data/mock_albums.dart';
import '../data/mock_artists.dart';
import 'album_screen.dart';
import 'artist_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _selected;

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
                const Text('Explore', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            CategoryChips(selected: _selected, onChanged: (v) => setState(() => _selected = v)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSection('ألبومات جديدة'),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mockAlbums.length,
                      itemBuilder: (_, i) => AlbumCard(album: mockAlbums[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumScreen(album: mockAlbums[i])))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSection('فنانين مقترحين'),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mockArtists.length,
                      itemBuilder: (_, i) => ArtistCard(artist: mockArtists[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArtistScreen(artist: mockArtists[i])))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
  );
}
