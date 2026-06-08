import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeAISuggestionBar extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onSuggestionTap;

  const RizeAISuggestionBar({super.key, required this.suggestions, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onSuggestionTap(suggestions[index]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [NewsColors.accent.withOpacity(0.8), Colors.purpleAccent.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(suggestions[index], style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
