import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WishlistButton extends StatefulWidget {
  final bool isInWishlist;
  final VoidCallback onToggle;

  const WishlistButton({super.key, required this.isInWishlist, required this.onToggle});

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: Icon(
        widget.isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: widget.isInWishlist ? ShopColors.accent : ShopColors.text2,
      ),
    );
  }
}
