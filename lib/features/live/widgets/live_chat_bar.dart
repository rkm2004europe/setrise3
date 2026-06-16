import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_comment_model.dart';

class LiveChatBar extends StatelessWidget {
  final List<LiveCommentModel> comments;
  const LiveChatBar({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: comments.length,
      itemBuilder: (_, i) {
        final c = comments[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: c.isGift
                ? Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(c.giftEmoji ?? '🎁', style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 4),
                    Text(c.text, style: const TextStyle(color: LiveColors.gold, fontSize: 12)),
                  ])
                : Text('${c.userName}: ${c.text}', style: const TextStyle(color: LiveColors.text, fontSize: 12)),
          ),
        );
      },
    );
  }
}
