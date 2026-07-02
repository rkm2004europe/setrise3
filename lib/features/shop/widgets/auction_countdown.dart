// lib/features/shop/widgets/auction_countdown.dart
// Timer.periodic فعلي

import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';

class AuctionCountdown extends StatefulWidget {
  final AuctionModel auction;
  final VoidCallback? onEnded;

  const AuctionCountdown({super.key, required this.auction, this.onEnded});

  @override
  State<AuctionCountdown> createState() => _AuctionCountdownState();
}

class _AuctionCountdownState extends State<AuctionCountdown> {
  late Duration _left;
  Timer? _timer;
  bool _ended = false;

  @override
  void initState() {
    super.initState();
    _left = widget.auction.timeLeft;
    if (_left <= Duration.zero) {
      _ended = true;
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _left = widget.auction.timeLeft;
        if (_left <= Duration.zero) {
          _ended = true;
          _timer?.cancel();
          widget.onEnded?.call();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    if (_ended) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_off, color: ShopColors.red, size: 14),
          SizedBox(width: 4),
          Text('انتهى المزاد',
            style: TextStyle(color: ShopColors.red, fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      );
    }

    final color = _left.inMinutes < 60 ? ShopColors.red : ShopColors.accent;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer, color: color, size: 14),
        const SizedBox(width: 4),
        Text(_format(_left),
          style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13,
            fontFeatures: const [FontFeature.tabularFigures()])),
      ],
    );
  }
}
