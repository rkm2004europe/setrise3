import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class HostInfoBar extends StatelessWidget {
  final LiveRoomModel room;
  const HostInfoBar({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => showUserPreviewSheet(context, userId: room.hostId, userName: room.hostName, username: '@${room.hostName}', accent: LiveColors.accent),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 16, backgroundColor: LiveColors.accent.withOpacity(0.2), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 16))),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(room.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700, fontSize: 14)),
                Text('${room.viewerCount} مشاهد', style: const TextStyle(color: LiveColors.text2, fontSize: 11)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
