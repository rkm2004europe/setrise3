// lib/features/chat/screens/widgets/reply_preview.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

class ReplyPreviewBar extends StatelessWidget {
  final ChatMessage replyTo;
  final VoidCallback onCancel;

  const ReplyPreviewBar({super.key, required this.replyTo, required this.onCancel});

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(children: [
      Container(width: 3, height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF007AFF),
          borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(replyTo.isMe ? 'أنت' : 'الطرف الآخر',
          style: const TextStyle(color: Color(0xFF007AFF), fontSize: 12,
            fontWeight: FontWeight.w700)),
        Text(replyTo.text ?? '📎 Media', maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13)),
      ])),
      CupertinoButton(padding: EdgeInsets.zero, onPressed: onCancel,
        child: const Icon(CupertinoIcons.xmark_circle_fill,
          color: Color(0xFF8E8E93), size: 20)),
    ]));
}

