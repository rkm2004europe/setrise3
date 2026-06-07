import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

/// يعرض قائمة منسدلة لاختيار مقطع موسيقي
class MusicPickerSheet extends StatelessWidget {
  final Function(String trackName) onTrackSelected;

  const MusicPickerSheet({super.key, required this.onTrackSelected});

  // بيانات وهمية (ستُستبدل بـ music/ service لاحقًا)
  static const _tracks = [
    {'title': 'Epic Beat', 'artist': 'Producer X'},
    {'title': 'Chill Vibes', 'artist': 'LoFi Studio'},
    {'title': 'Trap Energy', 'artist': 'BeatMaster'},
    {'title': 'Acoustic Mood', 'artist': 'Guitar Soul'},
    {'title': 'Original Sound', 'artist': 'SetRise Audio'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Add Music',
              style: TextStyle(
                color: PostColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                  final track = _tracks[index];
                  return ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: PostColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.music_note, color: PostColors.accent),
                    ),
                    title: Text(track['title']!,
                        style: const TextStyle(
                            color: PostColors.textPrimary,
                            fontWeight: FontWeight.w600)),
                    subtitle: Text(track['artist']!,
                        style: const TextStyle(color: PostColors.textSecondary)),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow_rounded,
                          color: PostColors.textPrimary),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        // معاينة مؤقتة
                      },
                    ),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      onTrackSelected(track['title']!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
