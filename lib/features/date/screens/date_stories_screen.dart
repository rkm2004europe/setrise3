import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/date_story_model.dart';
import '../data/mock_date_stories.dart';

class DateStoriesScreen extends StatelessWidget {
  const DateStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockDateStories.length,
                itemBuilder: (_, i) {
                  final story = mockDateStories[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 28, backgroundColor: DateColors.accent.withOpacity(0.1), child: Text(story.avatar, style: const TextStyle(fontSize: 24))),
                            if (story.isLive) Positioned(bottom: 0, right: 0, child: Container(width: 14, height: 14, decoration: const BoxDecoration(color: DateColors.like, shape: BoxShape.circle))),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(story.userName, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w700)),
                            Text('قبل ${DateTime.now().difference(story.createdAt).inHours} ساعة', style: const TextStyle(color: DateColors.text2, fontSize: 11)),
                          ]),
                        ),
                        if (story.isLive) Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: DateColors.like, borderRadius: BorderRadius.circular(12)), child: const Text('مباشر', style: TextStyle(color: Colors.white, fontSize: 10))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('القصص', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
