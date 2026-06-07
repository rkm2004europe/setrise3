import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/draft_model.dart';

class DraftCard extends StatelessWidget {
  final DraftModel draft;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DraftCard({
    super.key,
    required this.draft,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: PostColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image, color: PostColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(draft.caption ?? 'No caption', style: const TextStyle(color: PostColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Saved: ${draft.savedAt.toString().substring(0, 16)}', style: const TextStyle(color: PostColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: PostColors.textSecondary)),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: PostColors.red)),
        ],
      ),
    );
  }
}
