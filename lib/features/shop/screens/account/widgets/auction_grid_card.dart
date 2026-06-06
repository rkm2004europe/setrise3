here// lib/features/shop/screens/auction/widgets/auction_grid_card.dart

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/auction/auction_detail_screen.dart';

class AuctionGridCard extends StatefulWidget {
  final AuctionItem auction;
  const AuctionGridCard({super.key, required this.auction});

  @override
  State<AuctionGridCard> createState() => _AuctionGridCardState();
}

class _AuctionGridCardState extends State<AuctionGridCard> {
  late Timer _timer;
  late Duration _rem;

  @override
  void initState() {
    super.initState();
    _rem = widget.auction.endTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1),
      (_) => setState(() =>
        _rem = widget.auction.endTime.difference(DateTime.now())));
  }

  @override
  void dispose() { _timer.cancel(); super.dispose(); }

  String _fmt(Duration d) => d.isNegative ? 'Ended'
    : '${d.inHours}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final ended = _rem.isNegative;
    return GestureDetector(
      onTap: () => Navigator.push(context,
        CupertinoPageRoute(builder: (_) =>
          AuctionDetailScreen(auction: widget.auction))),
      child: Container(
        decoration: BoxDecoration(
          color: ShopColors.card,
          borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(widget.auction.imageUrl,
                width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: ShopColors.surface,
                  child: const Center(child: Icon(CupertinoIcons.photo,
                    color: ShopColors.grey, size: 36))))),
            if (!ended)
              Positioned(top: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: ShopColors.red,
                    borderRadius: BorderRadius.circular(4)),
                  child: const Row(children: [
                    Icon(Icons.circle, color: Colors.white, size: 6),
                    SizedBox(width: 3),
                    Text('LIVE', style: TextStyle(color: Colors.white,
                      fontSize: 10, fontWeight: FontWeight.w900)),
                  ]))),
          ])),
          Padding(padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.auction.name, style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text('\$${widget.auction.currentBid.toStringAsFixed(2)}',
                style: const TextStyle(color: ShopColors.accent,
                  fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Row(children: [
                Icon(CupertinoIcons.timer, size: 11,
                  color: ended ? ShopColors.red : Colors.orange),
                const SizedBox(width: 3),
                Text(_fmt(_rem), style: TextStyle(
                  color: ended ? ShopColors.red : Colors.orange,
                  fontSize: 11, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 2),
              Text('${widget.auction.bidCount} bids',
                style: const TextStyle(color: ShopColors.grey, fontSize: 10)),
            ])),
        ]),
      ),
    );
  }
}
