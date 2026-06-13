import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/date_story_model.dart';

class DateStoryTile extends StatelessWidget {
  final DateStoryModel story;
  final VoidCallback onTap;
  const DateStoryTile({super.key, required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 68, height: 68,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: story.isLive ? DateColors.like : DateColors.accent, width: 2)),
            child: CircleAvatar(backgroundColor: DateColors.surface, child: Text(story.avatar, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(height: 4),
          Text(story.userName, style: const TextStyle(color: DateColors.text, fontSize: 11)),
        ],
      ),
    );
  }
}
