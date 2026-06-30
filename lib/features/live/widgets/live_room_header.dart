import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveRoomHeader extends StatelessWidget {
  final LiveRoomModel room;
  const LiveRoomHeader({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showUserPreviewSheet(context, userId: room.hostId, userName: room.hostName, username: '@${room.hostName}', accent: LiveColors.accent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          CircleAvatar(radius: 18, backgroundColor: LiveColors.accent.withOpacity(0.2), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 18))),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(room.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700, fontSize: 14)),
            Text('${room.viewerCount} مشاهد', style: const TextStyle(color: LiveColors.text2, fontSize: 11)),
          ]),
          const SizedBox(width: 12),
          const Icon(Icons.verified, color: LiveColors.accent, size: 16),
        ]),
      ),
    );
  }
}
