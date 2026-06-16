import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';

class LiveRoomPreview extends StatelessWidget {
  final LiveRoomModel room;
  final VoidCallback onTap;

  const LiveRoomPreview({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: LiveColors.surface,
          border: Border.all(color: LiveColors.border),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  color: LiveColors.surface,
                  child: Center(child: Text(room.thumbnailEmoji ?? '🔴', style: const TextStyle(fontSize: 60))),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.8)]),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      CircleAvatar(radius: 12, backgroundColor: LiveColors.accent.withOpacity(0.2), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 12))),
                      const SizedBox(width: 6),
                      Expanded(child: Text(room.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700, fontSize: 13))),
                      Row(children: [
                        const Icon(Icons.visibility, color: LiveColors.text2, size: 12),
                        const SizedBox(width: 2),
                        Text('${room.viewerCount}', style: const TextStyle(color: LiveColors.text2, fontSize: 11)),
                      ]),
                    ]),
                    const SizedBox(height: 4),
                    Text(room.title, style: const TextStyle(color: LiveColors.text, fontSize: 12)),
                  ]),
                ),
              ),
              Positioned(top: 10, left: 10, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
