// lib/features/setrize/screens/widgets/stories_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/setrize/models/story_model.dart';

class SetrizeStoriesBar extends StatelessWidget {
  final List<StoryModel> stories;
  final ValueChanged<StoryModel> onStoryTap;

  const SetrizeStoriesBar({super.key, required this.stories, required this.onStoryTap});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 88,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: stories.length,
      itemBuilder: (_, i) => _Item(
        story: stories[i],
        onTap: () { HapticFeedback.selectionClick(); onStoryTap(stories[i]); }),
    ));
}

class _Item extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;
  const _Item({required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOwn  = story.status == StoryStatus.own;
    final isLive = story.isLive;

    return GestureDetector(onTap: onTap,
      child: Container(width: 66, margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(children: [
          Stack(alignment: Alignment.bottomRight, children: [
            Container(width: 58, height: 58,
              decoration: BoxDecoration(shape: BoxShape.circle,
                gradient: isOwn ? null : SweepGradient(colors: [
                  story.borderColor, story.borderColor.withOpacity(0.3), story.borderColor]),
                color: isOwn ? Colors.white24 : null),
              child: Padding(padding: const EdgeInsets.all(2.5),
                child: Container(decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  child: ClipOval(child: isOwn
                    ? const Icon(Icons.add_rounded, color: Colors.white70, size: 24)
                    : story.avatar != null
                      ? Image.network(story.avatar!, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _ph(story))
                      : _ph(story))))),
            if (isLive)
              Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black, width: 1.5)),
                child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 8,
                  fontWeight: FontWeight.w900, fontFamily: 'Inter'))),
          ]),
          const SizedBox(height: 5),
          Text(story.username.replaceFirst('@', ''),
            style: TextStyle(
              color: story.status == StoryStatus.seen ? Colors.white38 : Colors.white,
              fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
        ])));
  }

  Widget _ph(StoryModel s) => Center(child: Text(
    s.username.isNotEmpty ? s.username[0].toUpperCase() : '?',
    style: TextStyle(color: s.borderColor, fontWeight: FontWeight.w900, fontSize: 20)));
}
