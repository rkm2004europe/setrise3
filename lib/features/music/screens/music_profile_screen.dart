Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MusicProfileScreen extends StatelessWidget {
  const MusicProfileScreen({super.key});

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
                const Text('Music Profile', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  Center(child: CircleAvatar(radius: 50, backgroundColor: MusicColors.surface, child: Icon(Icons.person, size: 50, color: MusicColors.accent))),
                  SizedBox(height: 12),
                  Text('Top Artists', style: TextStyle(color: MusicColors.text, fontWeight: FontWeight.w800)),
                  Text('The Weeknd, Dua Lipa, Eminem', style: TextStyle(color: MusicColors.text2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
