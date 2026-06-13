import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../widgets/bubble.dart';

class StarredScreen extends StatelessWidget {
  final List<Message> starred;
  const StarredScreen({super.key, required this.starred});

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
                  const Text('الرسائل المميزة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: starred.isEmpty
                  ? const Center(child: Text('لا توجد رسائل مميزة', style: TextStyle(color: ChatColors.text2)))
                  : ListView.builder(
                      itemCount: starred.length,
                      itemBuilder: (ctx, i) => MessageBubble(message: starred[i], onLongPress: (_) {}, onReact: (_, __) {}),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
