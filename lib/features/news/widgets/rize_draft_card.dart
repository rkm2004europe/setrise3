import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';

class RizeDraftCard extends StatelessWidget {
  final RizePostModel draft;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RizeDraftCard({super.key, required this.draft, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NewsColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: NewsColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              draft.text.isEmpty ? 'No content' : draft.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: NewsColors.textPrimary),
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: NewsColors.textSecondary, size: 18)),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: NewsColors.likeActive, size: 18)),
        ],
      ),
    );
  }
}
