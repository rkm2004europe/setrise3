import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../controllers/for_you_controller.dart';
import '../widgets/music_card.dart';
import '../widgets/mini_player.dart';
import 'now_playing_screen.dart';
import 'search_screen.dart';
import 'library_screen.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  final _controller = ForYouController();
  final _pageCtrl = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _openPlayer(TrackModel track) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: track)));
  }

  void _onLike(TrackModel track) {
    setState(() => track.isLiked = !track.isLiked);
  }

  void _onShare(TrackModel track) {
    // ShareSheet.show(...)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageCtrl,
              scrollDirection: Axis.vertical,
              itemCount: _controller.tracks.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (_, i) {
                final track = _controller.tracks[i];
                return MusicCard(
                  track: track,
                  onTap: () => _openPlayer(track),
                  onLike: () => _onLike(track),
                  onShare: () => _onShare(track),
                );
              },
            ),
            Positioned(
              top: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('For You', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                      child: const Icon(Icons.search, color: MusicColors.text, size: 26),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LibraryScreen())),
                      child: const Icon(Icons.library_music, color: MusicColors.text, size: 26),
                    ),
                  ],
                ),
              ),
            ),
            if (_controller.tracks.isNotEmpty)
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: MiniPlayer(track: _controller.tracks[_currentIndex], onTap: () => _openPlayer(_controller.tracks[_currentIndex])),
              ),
          ],
        ),
      ),
    );
  }
}
