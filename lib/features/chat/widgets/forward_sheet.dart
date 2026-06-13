import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../data/conversations.dart';
import '../models/models.dart';

class ForwardSheet {
  static void show(BuildContext context, {required Message message}) {
    final conversations = mockConversations();
    showModalBottomSheet(
      context: context,
      backgroundColor: ChatColors.surface,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('إعادة توجيه إلى', style: TextStyle(color: ChatColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
            ),
            ...conversations.map((conv) => ListTile(
              leading: CircleAvatar(backgroundColor: ChatColors.surface, child: Text(conv.displayAvatar)),
              title: Text(conv.displayName, style: const TextStyle(color: ChatColors.text)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم الإرسال إلى ${conv.displayName}'), backgroundColor: ChatColors.accent),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
