import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ReplayChatOverlay extends StatelessWidget {
  final List<Map<String, String>> comments; // محاكاة
  const ReplayChatOverlay({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (_, i) => Text('${comments[i]['user']}: ${comments[i]['text']}', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
    );
  }
}
