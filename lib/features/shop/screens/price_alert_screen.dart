import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PriceAlertScreen extends StatefulWidget {
  final double currentPrice;
  const PriceAlertScreen({super.key, required this.currentPrice});

  @override
  State<PriceAlertScreen> createState() => _PriceAlertScreenState();
}

class _PriceAlertScreenState extends State<PriceAlertScreen> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.text = (widget.currentPrice * 0.8).toStringAsFixed(0);
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
              Text('السعر الحالي: \$${widget.currentPrice}', style: const TextStyle(color: ShopColors.text, fontSize: 18)),
              const SizedBox(height: 12),
              TextField(
                controller: _ctrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: ShopColors.text),
                decoration: InputDecoration(labelText: 'السعر المطلوب', labelStyle: const TextStyle(color: ShopColors.text2), filled: true, fillColor: ShopColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () { Navigator.pop(context); },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تفعيل التنبيه', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('تنبيه السعر', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
