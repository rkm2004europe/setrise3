import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_list_model.dart';

class RizeListTileWidget extends StatelessWidget {
  final RizeListModel list;
  final VoidCallback onTap;

  const RizeListTileWidget({super.key, required this.list, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: NewsColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.list, color: NewsColors.accent),
      ),
      title: Text(list.name, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w600)),
      subtitle: Text('${list.postsCount} posts', style: const TextStyle(color: NewsColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right, color: NewsColors.textSecondary),
      onTap: onTap,
    );
  }
}
