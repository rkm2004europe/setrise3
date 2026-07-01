import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_tracks.dart';
import '../data/mock_artists.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();

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
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MusicColors.text)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _ctrl, autofocus: true,
                      style: const TextStyle(color: MusicColors.text),
                      decoration: InputDecoration(hintText: 'بحث عن أغاني، فنانين...', hintStyle: TextStyle(color: MusicColors.text2.withOpacity(0.5)), border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('فنانين', style: TextStyle(color: MusicColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
                  ...mockArtists.map((a) => ListTile(
                    leading: CircleAvatar(backgroundColor: MusicColors.accent.withOpacity(0.1), child: Text(a.avatarEmoji)),
                    title: Text(a.name, style: const TextStyle(color: MusicColors.text)),
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
}
