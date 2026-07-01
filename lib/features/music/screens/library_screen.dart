import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_playlists.dart';

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
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSection('قوائم التشغيل'),
                  ...mockPlaylists.map((pl) => ListTile(
                    leading: Text(pl.coverEmoji, style: const TextStyle(fontSize: 28)),
                    title: Text(pl.name, style: const TextStyle(color: MusicColors.text, fontWeight: FontWeight.w600)),
                    subtitle: Text('${pl.trackCount} أغنية', style: const TextStyle(color: MusicColors.text2)),
                    onTap: () {},
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: const TextStyle(color: MusicColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
  );
}
