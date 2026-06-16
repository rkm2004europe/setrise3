import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../shar/screens/share_sheet.dart';
import '../models/live_room_model.dart';

class ShareLiveButton extends StatelessWidget {
  final LiveRoomModel room;
  const ShareLiveButton({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ShareSheet.show(context, data: ShareData(id: room.id, title: room.title, subtitle: room.hostName, accentColor: LiveColors.accent, link: 'https://setrise.app/live/${room.id}')),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
        child: const Icon(Icons.share, color: LiveColors.text, size: 20),
      ),
    );
  }
}
