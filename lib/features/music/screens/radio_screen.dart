import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

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
                const Text('Radio', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: List.generate(6, (i) => Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: MusicColors.surface, borderRadius: BorderRadius.circular(16)),
                  child: Center(child: Text('📻 محطة ${i+1}', style: const TextStyle(color: MusicColors.text))),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
