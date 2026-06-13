import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BidButton extends StatelessWidget {
  final VoidCallback onBid;
  const BidButton({super.key, required this.onBid});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onBid,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
      child: const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.gavel, color: Colors.white, size: 18),
        SizedBox(width: 6),
        Text('مزايدة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
      ]),
    ),
  );
}
