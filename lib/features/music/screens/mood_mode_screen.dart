import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_tracks.dart';
import '../widgets/music_card.dart';
import 'now_playing_screen.dart';

class MoodModeScreen extends StatelessWidget {
  const MoodModeScreen({super.key});

  static const _moods = ['😊 سعيد', '😢 حزين', '🔥 متحمس', '🧘 مسترخٍ', '💪 طاقة', '🌙 هادئ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MusicColors.text)),
                const SizedBox(width: 12),
                const Text('Mood Mode', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: _moods.map((m) => GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingScreen(track: mockTracks.first)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: MusicColors.border)),
                    child: Center(child: Text(m, style: const TextStyle(color: MusicColors.text, fontSize: 18, fontWeight: FontWeight.w600))),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
