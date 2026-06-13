import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class PinnedBar extends StatelessWidget {
  final Message message;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const PinnedBar({super.key, required this.message, required this.onTap, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        color: ChatColors.accent.withOpacity(0.1),
        child: Row(
          children: [
            const Icon(Icons.push_pin, color: ChatColors.accent, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message.text ?? 'وسائط',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: ChatColors.accent, fontSize: 13),
              ),
            ),
            GestureDetector(onTap: onClose, child: const Icon(Icons.close, color: ChatColors.accent, size: 16)),
          ],
        ),
      ),
    );
  }
}
