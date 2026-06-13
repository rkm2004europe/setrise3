import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final int count;
  const RatingBar({super.key, required this.rating, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) => Icon(
          i < rating.floor() ? Icons.star : (i < rating ? Icons.star_half : Icons.star_border),
          color: ShopColors.gold, size: 16,
        )),
        const SizedBox(width: 6),
        Text('$count تقييم', style: const TextStyle(color: ShopColors.text2, fontSize: 12)),
      ],
    );
  }
}
