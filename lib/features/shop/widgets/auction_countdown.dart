import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';

class AuctionCountdown extends StatefulWidget {
  final AuctionModel auction;
  const AuctionCountdown({super.key, required this.auction});

  @override
  State<AuctionCountdown> createState() => _AuctionCountdownState();
}

class _AuctionCountdownState extends State<AuctionCountdown> {
  late Duration _left;
  @override
  void initState() {
    super.initState();
    _left = widget.auction.timeLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_left.inHours}h ${_left.inMinutes % 60}m ${_left.inSeconds % 60}s',
      style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w700),
    );
  }
}
