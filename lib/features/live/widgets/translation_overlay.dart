import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TranslationOverlay extends StatelessWidget {
  final String original;
  final String translated;
  const TranslationOverlay({super.key, required this.original, required this.translated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(original, style: const TextStyle(color: LiveColors.text2, fontSize: 10)),
        Text(translated, style: const TextStyle(color: LiveColors.text, fontSize: 12)),
      ]),
    );
  }
}
