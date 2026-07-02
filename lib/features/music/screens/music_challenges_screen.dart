Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MusicChallengesScreen extends StatelessWidget {
  const MusicChallengesScreen({super.key});

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
                const Text('Music Challenges', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  ListTile(title: Text('🎤 خمن الأغنية', style: TextStyle(color: MusicColors.text)), subtitle: Text('استمع وخمن اسم الأغنية', style: TextStyle(color: MusicColors.text2))),
                  ListTile(title: Text('✍️ أكمل الكلمات', style: TextStyle(color: MusicColors.text)), subtitle: Text('أكمل كلمات الأغنية', style: TextStyle(color: MusicColors.text2))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
