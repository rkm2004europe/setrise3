import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_voice_rooms.dart';
import '../widgets/voice_room_card.dart';
import 'voice_room_screen.dart';

class VoiceRoomsFeedScreen extends StatelessWidget {
  const VoiceRoomsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = mockVoiceRooms.where((r) => r.isLive).toList();
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: rooms.isEmpty
                  ? const Center(child: Text('لا توجد غرف صوتية', style: TextStyle(color: LiveColors.text2)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: rooms.length,
                      itemBuilder: (_, i) => VoiceRoomCard(
                        room: rooms[i],
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VoiceRoomScreen(room: rooms[i]))),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('الغرف الصوتية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
