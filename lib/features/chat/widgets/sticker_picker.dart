import 'package:flutter/material.dart';
import '../theme/colors.dart';

class StickerPicker extends StatelessWidget {
  final Function(String) onSticker;
  const StickerPicker({super.key, required this.onSticker});

  final List<String> stickers = const ['😊', '😂', '❤️', '🔥', '👍', '😢', '🎉', '💪', '🤔', '😍'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      color: ChatColors.surface,
      child: GridView.count(
        crossAxisCount: 5,
        children: stickers.map((s) => GestureDetector(
          onTap: () => onSticker(s),
          child: Center(child: Text(s, style: const TextStyle(fontSize: 36))),
        )).toList(),
      ),
    );
  }
}
