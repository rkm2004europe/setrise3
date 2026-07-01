import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';

class LikeButton extends StatefulWidget {
  final TrackModel track;
  const LikeButton({super.key, required this.track});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => widget.track.isLiked = !widget.track.isLiked),
      child: Column(children: [
        Icon(
          widget.track.isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.track.isLiked ? MusicColors.like : MusicColors.text2,
          size: 24,
        ),
        const SizedBox(height: 4),
        const Text('Like', style: TextStyle(color: MusicColors.text2, fontSize: 11)),
      ]),
    );
  }
}
