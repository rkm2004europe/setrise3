import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/track_model.dart';
import '../controllers/library_controller.dart';

class LikeButton extends StatefulWidget {
  final TrackModel track;
  final LibraryController controller;
  const LikeButton({super.key, required this.track, required this.controller});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    final isLiked = widget.controller.isLiked(widget.track.id);
    return GestureDetector(
      onTap: () => widget.controller.toggleLike(widget.track),
      child: Column(children: [
        Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? MusicColors.like : MusicColors.text2, size: 24),
        const SizedBox(height: 4),
        const Text('Like', style: TextStyle(color: MusicColors.text2, fontSize: 11)),
      ]),
    );
  }
}
