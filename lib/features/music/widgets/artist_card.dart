import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/artist_model.dart';

class ArtistCard extends StatelessWidget {
  final ArtistModel artist;
  final VoidCallback onTap;

  const ArtistCard({super.key, required this.artist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundColor: MusicColors.accent.withOpacity(0.1), child: Text(artist.avatarEmoji, style: const TextStyle(fontSize: 36))),
            const SizedBox(height: 8),
            Text(artist.name, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w600, fontSize: 13), textAlign: TextAlign.center),
            Text('${artist.monthlyListeners ~/ 1000000}M', style: const TextStyle(color: MusicColors.text2, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
