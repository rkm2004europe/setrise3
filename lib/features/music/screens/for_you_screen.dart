import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../data/mock_tracks.dart';
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
  late PageController _pageCtrl;
  int _currentIndex = 0;
  late List<TrackModel> _tracks;
  TrackModel? _currentTrack;

  @override
  void initState() {
    super.initState();
    _tracks = List.from(mockTracks)..shuffle();
    _pageCtrl = PageController();
    _updateCurrentTrack();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _updateCurrentTrack() {
    if (_tracks.isNotEmpty && _currentIndex < _tracks.length) {
      _currentTrack = _tracks[_currentIndex];
    }
  }

  void _onPageChanged(int i) {
    setState(() {
      _currentIndex = i;
      _updateCurrentTrack();
    });
  }

  void _openPlayer() {
    if (_currentTrack != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: _currentTrack!)));
    }
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
              itemCount: _tracks.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (_, i) {
                final track = _tracks[i];
                return MusicCard(
                  track: track,
                  onTap: () => _openPlayer(),
                  onLike: () => setState(() => track.isLiked = !track.isLiked),
                  onShare: () {},
                );
              },
            ),
            Positioned(
              top: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            if (_currentTrack != null)
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: MiniPlayer(track: _currentTrack!, onTap: _openPlayer),
              ),
          ],
        ),
      ),
    );
  }
}
