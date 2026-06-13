import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../widgets/tile.dart';

class MutedConversationsScreen extends StatelessWidget {
  final List<Conversation> muted;
  const MutedConversationsScreen({super.key, required this.muted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
                  const SizedBox(width: 12),
                  const Text('المحادثات المكتومة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: muted.isEmpty
                  ? const Center(child: Text('لا توجد محادثات مكتومة', style: TextStyle(color: ChatColors.text2)))
                  : ListView.builder(
                      itemCount: muted.length,
                      itemBuilder: (ctx, i) => ConversationTile(conversation: muted[i], onTap: () {}),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
