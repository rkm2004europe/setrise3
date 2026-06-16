import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_comment_model.dart';
import '../models/vip_tier_model.dart';
import 'vip_chat_message.dart';

class LiveChatBar extends StatelessWidget {
  final List<LiveCommentModel> comments;
  // بيانات VIP وهمية – ستستبدل لاحقًا
  const LiveChatBar({super.key, required this.comments});

  VipTier _getTier(String userId) {
    // محاكاة: بعض المستخدمين VIP
    if (userId == 'v1') return VipTier.host;
    if (userId == 'v2') return VipTier.vip;
    return VipTier.normal;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: comments.length,
      itemBuilder: (_, i) {
        final comment = comments[i];
        final tier = _getTier(comment.userId);
        return VipChatMessage(comment: comment, tier: tier);
      },
    );
  }
}
