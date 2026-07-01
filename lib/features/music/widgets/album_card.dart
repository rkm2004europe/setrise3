import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final VoidCallback onTap;

  const AlbumCard({super.key, required this.album, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Text(album.coverEmoji, style: const TextStyle(fontSize: 60))),
          const SizedBox(height: 10),
          Text(album.title, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w700, fontSize: 14)),
          Text('${album.artist} • ${album.year}', style: const TextStyle(color: MusicColors.text2, fontSize: 12)),
        ]),
      ),
    );
  }
}
