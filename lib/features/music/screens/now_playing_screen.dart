import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../widgets/music_progress_bar.dart';
import '../widgets/like_button.dart';
import '../widgets/share_music_button.dart';
import '../../comment/screens/comments_screen.dart';
import '../../user/screens/user_preview_sheet.dart';

class NowPlayingScreen extends StatefulWidget {
  final TrackModel track;
  const NowPlayingScreen({super.key, required this.track});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.keyboard_arrow_down, color: MusicColors.text, size: 32),
                  ),
                  const Spacer(),
                  const Text('Now Playing', style: TextStyle(color: MusicColors.text2, fontSize: 13)),
                  const Spacer(),
                  ShareMusicButton(track: track),
                ],
              ),
            ),
            const Spacer(),
            // غلاف كبير
            Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                color: MusicColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: MusicColors.accent.withOpacity(0.3)),
              ),
              child: Center(child: Text(track.coverEmoji, style: const TextStyle(fontSize: 120))),
            ),
            const SizedBox(height: 30),
            // اسم الأغنية والفنان (قابل للنقر لفتح البروفايل)
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
            // شريط التقدم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MusicProgressBar(duration: track.duration),
            ),
            const SizedBox(height: 20),
            // أزرار التحكم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.shuffle, color: MusicColors.text2), onPressed: () {}),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.skip_previous, color: MusicColors.text, iconSize: 36), onPressed: () {}),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => setState(() => _isPlaying = !_isPlaying),
                  child: Container(
                    width: 72, height: 72,
                    decoration: const BoxDecoration(color: MusicColors.accent, shape: BoxShape.circle),
                    child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.skip_next, color: MusicColors.text, iconSize: 36), onPressed: () {}),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.repeat, color: MusicColors.text2), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 20),
            // أزرار التفاعل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LikeButton(track: track),
                _actionBtn(Icons.comment, 'Comments', () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => CommentsScreen(contextId: track.id, contextName: track.title, accent: MusicColors.accent),
                  ));
                }),
                _actionBtn(Icons.playlist_add, 'Add', () {}),
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
      child: Column(children: [
        Icon(icon, color: MusicColors.text2, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: MusicColors.text2, fontSize: 11)),
      ]),
    );
  }
}
