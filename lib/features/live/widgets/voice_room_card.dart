import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/voice_room_model.dart';

class VoiceRoomCard extends StatelessWidget {
  final VoiceRoomModel room;
  final VoidCallback onTap;

  const VoiceRoomCard({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: LiveColors.border)),
        child: Row(children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(room.topicEmoji ?? '🎙️', style: const TextStyle(fontSize: 24)))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(room.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Row(children: [
                CircleAvatar(radius: 10, backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 10))),
                const SizedBox(width: 6),
                Text(room.hostName, style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
              ]),
            ]),
          ),
          Column(children: [
            Row(children: [
              const Icon(Icons.headphones, color: LiveColors.text2, size: 14),
              const SizedBox(width: 4),
              Text('${room.listenerCount}', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.mic, color: LiveColors.text2, size: 14),
              const SizedBox(width: 4),
              Text('${room.speakerCount}', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
            ]),
          ]),
        ]),
      ),
    );
  }
}
