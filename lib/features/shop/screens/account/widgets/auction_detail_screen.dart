// lib/features/shop/screens/auction/auction_detail_screen.dart

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class AuctionDetailScreen extends StatefulWidget {
  final AuctionItem auction;
  const AuctionDetailScreen({super.key, required this.auction});

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  final _bidCtrl = TextEditingController();
  late Timer _timer;
  late Duration _remaining;
  double _currentBid = 0;

  @override
  void initState() {
    super.initState();
    _currentBid = widget.auction.currentBid;
    _remaining = widget.auction.endTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1),
      (_) => setState(() =>
        _remaining = widget.auction.endTime.difference(DateTime.now())));
  }

  @override
  void dispose() { _timer.cancel(); _bidCtrl.dispose(); super.dispose(); }

  String _fmt(Duration d) => d.isNegative ? 'Ended'
    : '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final ended = _remaining.isNegative;
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text(widget.auction.name,
          style: const TextStyle(color: Colors.white, fontSize: 17))),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.auction.imageUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200, color: ShopColors.surface))),
            const SizedBox(height: 16),
            Text(widget.auction.description,
              style: const TextStyle(color: ShopColors.grey)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ShopColors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                Row(children: [
                  const Icon(CupertinoIcons.timer, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text('Time: ${_fmt(_remaining)}',
                    style: TextStyle(
                      color: ended ? ShopColors.red : Colors.orange,
                      fontWeight: FontWeight.w700)),
                ]),
                const SizedBox(height: 8),
                Text('Current Bid: \$${_currentBid.toStringAsFixed(2)}',
                  style: const TextStyle(color: ShopColors.accent,
                    fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('${widget.auction.bidCount} bids',
                  style: const TextStyle(color: ShopColors.grey)),
              ])),
            if (!ended) ...[
              const SizedBox(height: 20),
              Row(children: [
                Expanded(child: CupertinoTextField(
                  controller: _bidCtrl,
                  keyboardType: TextInputType.number,
                  placeholder: 'Your bid (min \$${(_currentBid + 1).toStringAsFixed(2)})',
                  style: const TextStyle(color: Colors.white),
                  decoration: BoxDecoration(
                    color: ShopColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)))),
                const SizedBox(width: 12),
                CupertinoButton(
                  color: ShopColors.accent,
                  onPressed: () {
                    final bid = double.tryParse(_bidCtrl.text);
                    if (bid != null && bid > _currentBid) {
                      setState(() {
                        _currentBid = bid;
                        widget.auction.currentBid = bid;
                        widget.auction.bidCount++;
                      });
                      _bidCtrl.clear();
                    }
                  },
                  child: const Text('Place Bid',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
              ]),
            ],
          ])),
      ),
    );
  }
}

