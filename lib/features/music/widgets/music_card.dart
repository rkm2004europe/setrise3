import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../../comment/screens/comments_screen.dart';

class MusicCard extends StatefulWidget {
  final TrackModel track;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const MusicCard({super.key, required this.track, required this.onTap, required this.onLike, required this.onShare});

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  double _dragX = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: (d) => setState(() => _dragX += d.delta.dx),
      onPanEnd: (d) {
        if (_dragX.abs() > 100) {
          if (_dragX > 0) { widget.onLike(); } else { widget.onShare(); }
        }
        setState(() => _dragX = 0);
      },
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [MusicColors.surface, MusicColors.bg])),
          child: Stack(
            children: [
              Center(child: Container(width: 280, height: 280, decoration: BoxDecoration(color: MusicColors.accent.withOpacity(0.15), borderRadius: BorderRadius.circular(24), border: Border.all(color: MusicColors.accent.withOpacity(0.3))), child: Center(child: Text(widget.track.coverEmoji, style: const TextStyle(fontSize: 100))))),
              Positioned(bottom: 100, left: 20, right: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.track.title, style: const TextStyle(color: MusicColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(widget.track.artist, style: const TextStyle(color: MusicColors.text2, fontSize: 16)),
              ])),
              Positioned(right: 16, bottom: 100, child: Column(children: [
                _btn(Icons.favorite, widget.track.isLiked ? MusicColors.like : MusicColors.text2, widget.onLike),
                const SizedBox(height: 16),
                _btn(Icons.comment, MusicColors.text2, () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsScreen(contextId: widget.track.id, contextName: widget.track.title, accent: MusicColors.accent)))),
                const SizedBox(height: 16),
                _btn(Icons.share, MusicColors.text2, widget.onShare),
              ])),
              if (_dragX > 60) Positioned(top: 40, left: 20, child: Transform.rotate(angle: -0.2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: MusicColors.like, borderRadius: BorderRadius.circular(12)), child: const Text('LIKE', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900))))),
              if (_dragX < -60) Positioned(top: 40, right: 20, child: Transform.rotate(angle: 0.2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: MusicColors.text2, borderRadius: BorderRadius.circular(12)), child: const Text('NEXT', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900))))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Column(children: [Icon(icon, color: color, size: 30), const SizedBox(height: 4)]));
  }
}
