import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InstallmentPaymentScreen extends StatefulWidget {
  final double totalAmount;
  const InstallmentPaymentScreen({super.key, required this.totalAmount});

  @override
  State<InstallmentPaymentScreen> createState() => _InstallmentPaymentScreenState();
}

class _InstallmentPaymentScreenState extends State<InstallmentPaymentScreen> {
  int _months = 3;

  @override
  Widget build(BuildContext context) {
    final monthly = widget.totalAmount / _months;
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Text('المبلغ الإجمالي: \$${widget.totalAmount.toStringAsFixed(2)}', style: const TextStyle(color: ShopColors.text, fontSize: 18)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildOption(3),
                _buildOption(6),
                _buildOption(12),
              ]),
              const SizedBox(height: 20),
              Text('القسط الشهري: \$${monthly.toStringAsFixed(2)}', style: const TextStyle(color: ShopColors.accent, fontSize: 20, fontWeight: FontWeight.w800)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تأكيد خطة التقسيط', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int months) => GestureDetector(
    onTap: () => setState(() => _months = months),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: _months == months ? ShopColors.accent : ShopColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _months == months ? ShopColors.accent : ShopColors.border),
      ),
      child: Text('$months شهور', style: TextStyle(color: _months == months ? Colors.white : ShopColors.text)),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('التقسيط', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
