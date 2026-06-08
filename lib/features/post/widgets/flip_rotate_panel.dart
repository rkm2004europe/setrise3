import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FlipRotatePanel extends StatelessWidget {
  final VoidCallback onFlipHorizontal;
  final VoidCallback onFlipVertical;
  final VoidCallback onRotateLeft;
  final VoidCallback onRotateRight;

  const FlipRotatePanel({
    super.key,
    required this.onFlipHorizontal,
    required this.onFlipVertical,
    required this.onRotateLeft,
    required this.onRotateRight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _IconBtn(icon: Icons.flip, label: 'Flip H', onTap: onFlipHorizontal),
        _IconBtn(icon: Icons.flip_to_back, label: 'Flip V', onTap: onFlipVertical),
        _IconBtn(icon: Icons.rotate_left, label: 'Rotate L', onTap: onRotateLeft),
        _IconBtn(icon: Icons.rotate_right, label: 'Rotate R', onTap: onRotateRight),
      ],
    );
  }

  Widget _IconBtn({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: PostColors.textPrimary, size: 22),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: PostColors.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }
}
