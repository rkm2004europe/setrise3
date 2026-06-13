import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class ReplyBar extends StatelessWidget {
  final Message replyTo;
  final VoidCallback onCancel;

  const ReplyBar({super.key, required this.replyTo, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: ChatColors.surface,
      child: Row(
        children: [
          Container(width: 3, height: 30, color: ChatColors.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              replyTo.text ?? 'وسائط',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: ChatColors.text2),
            ),
          ),
          GestureDetector(onTap: onCancel, child: const Icon(Icons.close, color: ChatColors.text2, size: 18)),
        ],
      ),
    );
  }
}
