import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/search_controller.dart';
import '../widgets/track_tile.dart';
import 'now_playing_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  final _searchCtrl = SearchController();

  void _search(String q) => _searchCtrl.search(q);

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
                      onChanged: _search,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _searchCtrl,
                builder: (_, __) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchCtrl.results.length,
                  itemBuilder: (_, i) => TrackTile(track: _searchCtrl.results[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: _searchCtrl.results[i])))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
