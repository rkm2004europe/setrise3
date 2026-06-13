import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/auction_model.dart';

class AuctionBidScreen extends StatefulWidget {
  final AuctionModel auction;
  const AuctionBidScreen({super.key, required this.auction});

  @override
  State<AuctionBidScreen> createState() => _AuctionBidScreenState();
}

class _AuctionBidScreenState extends State<AuctionBidScreen> {
  final _amountCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountCtrl.text = (widget.auction.currentBid + 5).toString();
  }

  void _placeBid() {
    HapticFeedback.mediumImpact();
    final amount = double.tryParse(_amountCtrl.text) ?? widget.auction.currentBid + 5;
    if (amount > widget.auction.currentBid) {
      setState(() {
        widget.auction.currentBid = amount;
        widget.auction.highestBidderId = 'me';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت المزايدة! السعر الجديد: \$$amount'), backgroundColor: ShopColors.accent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Text(widget.auction.productName, style: const TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text('السعر الحالي: \$${widget.auction.currentBid}', style: const TextStyle(color: ShopColors.accent, fontSize: 28, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: ShopColors.text, fontSize: 24),
                decoration: InputDecoration(
                  labelText: 'قيمة المزايدة',
                  labelStyle: const TextStyle(color: ShopColors.text2),
                  filled: true, fillColor: ShopColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _placeBid,
                child: Container(
                  width: double.infinity, height: 56,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(16)),
                  child: const Center(child: Text('تقديم المزايدة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('المزايدة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
