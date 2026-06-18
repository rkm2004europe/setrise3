import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_comment_model.dart';
import '../models/vip_system_model.dart';
import 'vip_chat_badge.dart';
import 'vip_badge.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveChatBar extends StatelessWidget {
  final List<LiveCommentModel> comments;
  const LiveChatBar({super.key, required this.comments});

  String _getVipLevel(String userId) {
    if (userId == 'v1') return 'Diamond VIP';
    if (userId == 'v2') return 'VIP';
    if (userId == 'h1') return 'Legend';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: comments.length,
      itemBuilder: (_, i) {
        final comment = comments[i];
        final vip = _getVipLevel(comment.userId);
        return GestureDetector(
          onTap: () => showUserPreviewSheet(
            context,
            userId: comment.userId,
            userName: comment.userName,
            username: '@${comment.userName}',
            accent: LiveColors.accent,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: vip.isNotEmpty ? LiveColors.gold.withOpacity(0.1) : Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: vip.isNotEmpty ? Border.all(color: LiveColors.gold.withOpacity(0.3)) : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (vip.isNotEmpty) ...[
                  VipChatBadge(vipLevel: vip),
                  const SizedBox(width: 4),
                ],
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${comment.userName}: ',
                          style: TextStyle(
                            color: vip.isNotEmpty ? LiveColors.gold : LiveColors.text,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: comment.text,
                          style: const TextStyle(color: LiveColors.text, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
