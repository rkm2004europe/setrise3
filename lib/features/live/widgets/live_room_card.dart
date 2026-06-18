import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveRoomCard extends StatelessWidget {
  final LiveRoomModel room;
  final VoidCallback onTap;

  const LiveRoomCard({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: LiveColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: LiveColors.border.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الغلاف
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 180,
                width: double.infinity,
                color: LiveColors.accent.withOpacity(0.1),
                child: Stack(
                  children: [
                    Center(child: Text(room.thumbnailEmoji ?? '🔴', style: const TextStyle(fontSize: 64))),
                    // شارة LIVE
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(8)),
                        child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                    ),
                    // عدد المشاهدين
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(8)),
                        child: Row(children: [
                          const Icon(Icons.visibility, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text('${room.viewerCount}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // معلومات المضيف
            Row(children: [
              GestureDetector(
                onTap: () => showUserPreviewSheet(
                  context, userId: room.hostId, userName: room.hostName,
                  username: '@${room.hostName}', accent: LiveColors.accent,
                ),
                child: CircleAvatar(radius: 18, backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 18))),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(room.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 8),
            Text(room.title, style: const TextStyle(color: LiveColors.text, fontSize: 14)),
            if (room.tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: room.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(tag, style: const TextStyle(color: LiveColors.accent, fontSize: 10)),
                    )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
