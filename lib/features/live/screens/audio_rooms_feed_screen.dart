import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_audio_room_model.dart';
import '../data/mock_audio_rooms.dart';
import 'live_audio_room_screen.dart';

class AudioRoomsFeedScreen extends StatelessWidget {
  const AudioRoomsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = mockAudioRooms.where((r) => r.isLive).toList();

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
                      itemBuilder: (_, i) {
                        final room = rooms[i];
                        return _buildRoomCard(context, room);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, LiveAudioRoomModel room) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LiveAudioRoomScreen(room: room)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: LiveColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: LiveColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            // صورة المضيف
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: LiveColors.accent.withOpacity(0.15),
                  child: Text(room.hostAvatar, style: const TextStyle(fontSize: 24)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14, height: 14,
                    decoration: const BoxDecoration(color: LiveColors.online, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(room.hostName, style: const TextStyle(color: LiveColors.text2, fontSize: 13)),
                      const Spacer(),
                      const Icon(Icons.headphones, color: LiveColors.text2, size: 14),
                      const SizedBox(width: 4),
                      Text('${room.listenerCount}', style: const TextStyle(color: LiveColors.text2, fontSize: 13)),
                    ],
                  ),
                  if (room.speakers.length > 1) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.people, color: LiveColors.text2, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${room.speakers.length} متحدثين',
                          style: const TextStyle(color: LiveColors.text2, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // أيقونة الدخول
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: LiveColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: LiveColors.accent, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: LiveColors.text),
            ),
            const SizedBox(width: 12),
            const Text('الغرف الصوتية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
