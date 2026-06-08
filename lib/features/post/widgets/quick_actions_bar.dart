import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QuickActionsBar extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onText;
  final VoidCallback onProduct;

  const QuickActionsBar({
    super.key,
    required this.onCamera,
    required this.onGallery,
    required this.onText,
    required this.onProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickAction(icon: Icons.camera_alt_rounded, label: 'Camera', onTap: onCamera),
          _QuickAction(icon: Icons.photo_library_rounded, label: 'Gallery', onTap: onGallery),
          _QuickAction(icon: Icons.edit_rounded, label: 'Text', onTap: onText),
          _QuickAction(icon: Icons.shopping_bag_rounded, label: 'Product', onTap: onProduct),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: PostColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: PostColors.accent, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }
}
