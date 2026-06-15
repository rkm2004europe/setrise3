import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/map_story_model.dart';

class StoryCluster extends StatelessWidget {
  final List<MapStoryModel> stories;
  final MapStoryModel initialStory;
  const StoryCluster({super.key, required this.stories, required this.initialStory});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MapColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Text('ستوريات ${initialStory.locationName}', style: const TextStyle(color: MapColors.text, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (_, i) {
                final story = stories[i];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100, margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(color: MapColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: story.isLive ? MapColors.red : MapColors.border)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CircleAvatar(radius: 25, backgroundColor: MapColors.accent.withOpacity(0.1), child: Text(story.avatar, style: const TextStyle(fontSize: 24))),
                      const SizedBox(height: 6),
                      Text(story.userName, style: const TextStyle(color: MapColors.text, fontSize: 12)),
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
