import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class AICaptionButton extends StatelessWidget {
  final VoidCallback onGenerating;
  final ValueChanged<String> onCaptionGenerated;

  const AICaptionButton({
    super.key,
    required this.onGenerating,
    required this.onCaptionGenerated,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.selectionClick();
        onGenerating();
        // Simulate AI generation
        await Future.delayed(const Duration(seconds: 1));
        onCaptionGenerated('Check out this amazing moment! 🔥 #ai_generated');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              PostColors.accent.withOpacity(0.8),
              Colors.purpleAccent.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: PostColors.accent.withOpacity(0.3),
              blurRadius: 12,
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Text(
              'AI Caption',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
