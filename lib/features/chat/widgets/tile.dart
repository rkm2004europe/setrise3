import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;
  final String? draftText;

  const ConversationTile({super.key, required this.conversation, required this.onTap, this.draftText});

  @override
  Widget build(BuildContext context) {
    final conv = conversation;
    final lastMsg = conv.lastMessage;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ChatColors.border.withOpacity(0.3))),
        ),
        child: Row(
          children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, color: ChatColors.surface),
              child: Center(child: Text(conv.displayAvatar, style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(conv.displayName, style: const TextStyle(color: ChatColors.text, fontWeight: FontWeight.w600, fontSize: 16))),
                      if (conv.unread > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: ChatColors.accent, shape: BoxShape.circle),
                          child: Text('${conv.unread}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    draftText ?? lastMsg?.text ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: draftText != null ? ChatColors.accent : (conv.unread > 0 ? ChatColors.text : ChatColors.text2),
                      fontSize: 13,
                      fontStyle: draftText != null ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
