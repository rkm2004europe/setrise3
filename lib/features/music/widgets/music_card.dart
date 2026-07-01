import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../../comment/screens/comments_screen.dart';
import '../../shar/screens/share_sheet.dart';

class MusicCard extends StatelessWidget {
  final TrackModel track;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const MusicCard({
    super.key,
    required this.track,
    required this.onTap,
    required this.onLike,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MusicColors.surface, MusicColors.bg],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 280, height: 280,
                decoration: BoxDecoration(
                  color: MusicColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: MusicColors.accent.withOpacity(0.3)),
                ),
                child: Center(child: Text(track.coverEmoji, style: const TextStyle(fontSize: 100))),
              ),
            ),
            Positioned(
              bottom: 100, left: 20, right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(track.title, style: const TextStyle(color: MusicColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(track.artist, style: const TextStyle(color: MusicColors.text2, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(track.album, style: const TextStyle(color: MusicColors.text2, fontSize: 13)),
                ],
              ),
            ),
            Positioned(
              right: 16, bottom: 100,
              child: Column(
                children: [
                  _actionBtn(Icons.favorite, track.isLiked ? MusicColors.like : MusicColors.text2, onLike),
                  const SizedBox(height: 16),
                  _actionBtn(Icons.comment, MusicColors.text2, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => CommentsScreen(contextId: track.id, contextName: track.title, accent: MusicColors.accent),
                    ));
                  }),
                  const SizedBox(height: 16),
                  _actionBtn(Icons.share, MusicColors.text2, onShare),
                  const SizedBox(height: 16),
                  _actionBtn(Icons.playlist_add, MusicColors.text2, () {}),
                ],
              ),
            ),
            Positioned(top: 120, left: 16, child: _swipeHint('NEXT', MusicColors.text2)),
            Positioned(top: 120, right: 16, child: _swipeHint('PREV', MusicColors.text2)),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [Icon(icon, color: color, size: 30), const SizedBox(height: 4)]),
    );
  }

  Widget _swipeHint(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
