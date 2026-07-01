import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_artists.dart';
import '../widgets/artist_card.dart';
import 'artist_screen.dart';

class RisingArtistsScreen extends StatelessWidget {
  const RisingArtistsScreen({super.key});

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
                const Text('Rising Artists', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockArtists.length,
                itemBuilder: (_, i) => ArtistCard(artist: mockArtists[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArtistScreen(artist: mockArtists[i])))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
