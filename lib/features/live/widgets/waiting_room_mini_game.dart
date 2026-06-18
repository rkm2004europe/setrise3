import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WaitingRoomMiniGame extends StatefulWidget {
  const WaitingRoomMiniGame({super.key});

  @override
  State<WaitingRoomMiniGame> createState() => _WaitingRoomMiniGameState();
}

class _WaitingRoomMiniGameState extends State<WaitingRoomMiniGame> {
  int _score = 0;
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() { _taps++; if (_taps % 5 == 0) _score++; }),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Text('اضغط بسرعة!', style: TextStyle(color: LiveColors.text2)),
          const SizedBox(height: 8),
          Text('$_score', style: const TextStyle(color: LiveColors.gold, fontSize: 32, fontWeight: FontWeight.w900)),
        ]),
      ),
    );
  }
}
