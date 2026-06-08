import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HashtagSuggestion extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onHashtagSelected;

  const HashtagSuggestion({super.key, required this.suggestions, required this.onHashtagSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: suggestions.map((tag) {
        return GestureDetector(
          onTap: () => onHashtagSelected('#$tag'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PostColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: PostColors.accent.withOpacity(0.3)),
            ),
            child: Text('#$tag', style: TextStyle(color: PostColors.accent, fontWeight: FontWeight.w600, fontSize: 12)),
          ),
        );
      }).toList(),
    );
  }
}
