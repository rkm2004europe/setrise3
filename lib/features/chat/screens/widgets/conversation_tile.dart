// lib/features/chat/screens/widgets/conversation_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({super.key, required this.conversation, required this.onTap});

  String _timeAgo(DateTime? d) {
    if (d == null) return '';
    final diff = DateTime.now().difference(d);
    if (diff.inDays >= 7) return '${d.day}/${d.month}';
    if (diff.inDays >= 1) return '${diff.inDays}d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return 'now';
  }

  @override
  Widget build(BuildContext context) {
    final c = conversation;
    final hasUnread = c.unreadCount > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          // Avatar
          Stack(children: [
            CircleAvatar(radius: 28,
              backgroundColor: const Color(0xFFE5E5EA),
              child: Text(c.name[0], style: const TextStyle(
                color: Color(0xFF3C3C43), fontWeight: FontWeight.w700,
                fontSize: 20))),
            if (c.isOnline)
              Positioned(bottom: 0, right: 0,
                child: Container(width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759), shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)))),
          ]),
          const SizedBox(width: 12),

          // Info
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              if (c.isPinned)
                const Padding(padding: EdgeInsets.only(right: 4),
                  child: Icon(CupertinoIcons.pin_fill,
                    size: 12, color: Color(0xFF8E8E93))),
              Flexible(child: Text(c.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                  color: Colors.black), overflow: TextOverflow.ellipsis)),
              if (c.isVerified) ...[
                const SizedBox(width: 3),
                const Icon(Icons.verified_rounded, color: Color(0xFF007AFF), size: 14)],
              const Spacer(),
              Text(_timeAgo(c.lastMessageTime),
                style: TextStyle(fontSize: 13,
                  color: hasUnread ? const Color(0xFF007AFF) : const Color(0xFF8E8E93))),
            ]),
            const SizedBox(height: 3),
            Row(children: [
              // Sent status ticks
              if (c.lastMessageStatus != null) ...[
                Icon(c.lastMessageStatus == MessageStatus.read
                  ? CupertinoIcons.checkmark_alt : CupertinoIcons.checkmark,
                  size: 13, color: c.lastMessageStatus == MessageStatus.read
                    ? const Color(0xFF4FC3F7) : const Color(0xFF8E8E93)),
                const SizedBox(width: 3),
              ],
              if (c.isMuted)
                const Padding(padding: EdgeInsets.only(right: 3),
                  child: Icon(CupertinoIcons.bell_slash, size: 13, color: Color(0xFF8E8E93))),
              Expanded(child: Text(c.lastMessage ?? '',
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14,
                  color: hasUnread ? Colors.black : const Color(0xFF8E8E93),
                  fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal))),
              if (hasUnread)
                Container(width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: c.isMuted ? const Color(0xFF8E8E93) : const Color(0xFF007AFF),
                    shape: BoxShape.circle),
                  child: Center(child: Text('${c.unreadCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 11,
                      fontWeight: FontWeight.w700)))),
            ]),
          ])),
        ])));
  }
}
