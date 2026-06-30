import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InteractiveWaitingRoom extends StatefulWidget {
  final String hostName;
  final VoidCallback onStart;
  const InteractiveWaitingRoom({super.key, required this.hostName, required this.onStart});

  @override
  State<InteractiveWaitingRoom> createState() => _InteractiveWaitingRoomState();
}

class _InteractiveWaitingRoomState extends State<InteractiveWaitingRoom> {
  int _countdown = 10;
  bool _isCounting = false;

  void _startCountdown() {
    setState(() => _isCounting = true);
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _countdown--);
      if (_countdown <= 0) { widget.onStart(); return false; }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        if (_isCounting)
          Text('$_countdown', style: const TextStyle(color: LiveColors.accent, fontSize: 48, fontWeight: FontWeight.w900))
        else
          GestureDetector(
            onTap: _startCountdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
              child: const Text('ابدأ البث', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
            ),
          ),
      ]),
    );
  }
}
