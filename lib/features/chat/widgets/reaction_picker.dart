import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ReactionPicker extends StatelessWidget {
  final Function(String) onReact;
  const ReactionPicker({super.key, required this.onReact});

  final List<String> emojis = const ['❤️', '😂', '😮', '😢', '😡', '👍'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: emojis.map((e) => GestureDetector(
          onTap: () => onReact(e),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(e, style: const TextStyle(fontSize: 24)),
          ),
        )).toList(),
      ),
    );
  }
}
