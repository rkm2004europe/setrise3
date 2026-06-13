import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onSearchTap;

  const ChatAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: ChatColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
          const Spacer(),
          if (onSearchTap != null)
            IconButton(
              icon: const Icon(Icons.search, color: ChatColors.accent, size: 24),
              onPressed: onSearchTap,
            ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
