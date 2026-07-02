import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../widgets/music_progress_bar.dart';
import '../widgets/like_button.dart';
import '../widgets/share_music_button.dart';
import '../widgets/now_playing_swipe.dart';
import '../controllers/library_controller.dart';
import '../../comment/screens/comments_screen.dart';
import '../../user/screens/user_preview_sheet.dart';
import 'lyrics_screen.dart';
import '../widgets/music_queue_sheet.dart';

class NowPlayingScreen extends StatefulWidget {
  final TrackModel track;
  const NowPlayingScreen({super.key, required this.track});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool _isPlaying = true;
  final _libraryCtrl = LibraryController();

  @override
  void initState() {
    super.initState();
    _libraryCtrl.addToRecentlyPlayed(widget.track);
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.keyboard_arrow_down, color: MusicColors.text, size: 32)),
                  const Spacer(),
                  const Text('Now Playing', style: TextStyle(color: MusicColors.text2, fontSize: 13)),
                  const Spacer(),
                  ShareMusicButton(track: track),
                ],
              ),
            ),
            const Spacer(),
            NowPlayingSwipe(
              track: track,
              onNext: () {},
              onPrevious: () {},
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => showUserPreviewSheet(context, userId: track.artist, userName: track.artist, username: '@${track.artist}', accent: MusicColors.accent),
              child: Column(
                children: [
                  Text(track.title, style: const TextStyle(color: MusicColors.text, fontSize: 24, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
                  const SizedBox(height: 6),
                  Text(track.artist, style: const TextStyle(color: MusicColors.accent, fontSize: 16)),
                  Text(track.album, style: const TextStyle(color: MusicColors.text2, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MusicProgressBar(duration: track.duration),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.shuffle, color: MusicColors.text2), onPressed: () {}),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.skip_previous, color: MusicColors.text, iconSize: 36), onPressed: () {}),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => setState(() => _isPlaying = !_isPlaying),
                  child: Container(width: 72, height: 72, decoration: const BoxDecoration(color: MusicColors.accent, shape: BoxShape.circle), child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40)),
                ),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.skip_next, color: MusicColors.text, iconSize: 36), onPressed: () {}),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.repeat, color: MusicColors.text2), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LikeButton(track: track, controller: _libraryCtrl),
                _actionBtn(Icons.comment, 'Comments', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsScreen(contextId: track.id, contextName: track.title, accent: MusicColors.accent)));
                }),
                _actionBtn(Icons.playlist_add, 'Add', () {}),
                _actionBtn(Icons.lyrics, 'Lyrics', () => Navigator.push(context, MaterialPageRoute(builder: (_) => LyricsScreen(trackTitle: track.title)))),
                _actionBtn(Icons.queue_music, 'Queue', () => showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => const MusicQueueSheet(queue: []))),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [Icon(icon, color: MusicColors.text2, size: 24), const SizedBox(height: 4), Text(label, style: const TextStyle(color: MusicColors.text2, fontSize: 11))]),
    );
  }
}
