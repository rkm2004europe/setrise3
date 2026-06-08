import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrivacySelector extends StatelessWidget {
  final String selectedPrivacy;
  final ValueChanged<String> onPrivacyChanged;

  const PrivacySelector({
    super.key,
    required this.selectedPrivacy,
    required this.onPrivacyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['Public', 'Friends', 'Private'];
    return Row(
      children: options.map((privacy) {
        final selected = selectedPrivacy == privacy;
        return GestureDetector(
          onTap: () => onPrivacyChanged(privacy),
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? PostColors.accent : Colors.white10,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? PostColors.accent : Colors.white24),
            ),
            child: Text(privacy, style: TextStyle(color: selected ? Colors.white : Colors.white70, fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }
}
