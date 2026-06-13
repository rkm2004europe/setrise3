import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final Function(Message) onLongPress;
  final Function(Message, String) onReact;

  const MessageBubble({super.key, required this.message, required this.onLongPress, required this.onReact});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return GestureDetector(
      onLongPress: () => onLongPress(message),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? ChatColors.outgoing : ChatColors.incoming,
            borderRadius: BorderRadius.circular(18),
          ),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: message.type == MsgType.text
              ? Text(message.text ?? '', style: const TextStyle(color: Colors.white, fontSize: 15))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message.mediaEmoji ?? '📎', style: const TextStyle(fontSize: 32)),
                    if (message.fileName != null) ...[const SizedBox(width: 8), Text(message.fileName!, style: const TextStyle(color: Colors.white, fontSize: 13))],
                  ],
                ),
        ),
      ),
    );
  }
}
