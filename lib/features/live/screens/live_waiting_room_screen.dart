import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/waiting_room_mini_game.dart';

class LiveWaitingRoomScreen extends StatefulWidget {
  final String hostName;
  final DateTime startTime;
  const LiveWaitingRoomScreen({super.key, required this.hostName, required this.startTime});

  @override
  State<LiveWaitingRoomScreen> createState() => _LiveWaitingRoomScreenState();
}

class _LiveWaitingRoomScreenState extends State<LiveWaitingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.live_tv, size: 80, color: LiveColors.accent),
            const SizedBox(height: 16),
            Text('سيبدأ ${widget.hostName} قريباً', style: const TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('${widget.startTime.hour}:${widget.startTime.minute}', style: const TextStyle(color: LiveColors.text2)),
            const SizedBox(height: 20),
            const WaitingRoomMiniGame(),
          ]),
        ),
      ),
    );
  }
}
