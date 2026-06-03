// lib/features/chat/screens/widgets/chat_app_bar.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Conversation conversation;
  final VoidCallback onSearchTap;

  const ChatAppBar({
    super.key, required this.conversation, required this.onSearchTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context),
        child: const Row(children: [
          SizedBox(width: 4),
          Icon(CupertinoIcons.chevron_left, color: Color(0xFF007AFF), size: 20),
          Text('Back', style: TextStyle(color: Color(0xFF007AFF), fontSize: 16)),
        ])),
      leadingWidth: 80,
      title: GestureDetector(
        onTap: () {},
        child: Row(children: [
          Stack(children: [
            CircleAvatar(radius: 18,
              backgroundColor: const Color(0xFFE5E5EA),
              child: Text(conversation.name[0],
                style: const TextStyle(color: Color(0xFF3C3C43),
                  fontWeight: FontWeight.w700))),
            if (conversation.isOnline)
              Positioned(bottom: 0, right: 0,
                child: Container(width: 10, height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759), shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5)))),
          ]),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Flexible(child: Text(conversation.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                  color: Colors.black), overflow: TextOverflow.ellipsis)),
              if (conversation.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified_rounded, color: Color(0xFF007AFF), size: 14)],
            ]),
            Text(conversation.isOnline ? 'Online' : 'Last seen recently',
              style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93))),
          ])),
        ])),
      actions: [
        CupertinoButton(padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(CupertinoIcons.phone_fill,
            color: Color(0xFF007AFF), size: 22)),
        CupertinoButton(padding: EdgeInsets.zero,
          onPressed: onSearchTap,
          child: const Icon(CupertinoIcons.search,
            color: Color(0xFF007AFF), size: 22)),
        const SizedBox(width: 4),
      ],
      bottom: PreferredSize(preferredSize: const Size.fromHeight(0.5),
        child: Divider(height: 0.5, thickness: 0.5,
          color: Colors.black.withOpacity(0.1))),
    );
  }
}

