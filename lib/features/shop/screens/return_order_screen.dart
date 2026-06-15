import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ReturnOrderScreen extends StatefulWidget {
  const ReturnOrderScreen({super.key});

  @override
  State<ReturnOrderScreen> createState() => _ReturnOrderScreenState();
}

class _ReturnOrderScreenState extends State<ReturnOrderScreen> {
  String _reason = '';

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
              const Text('سبب الإرجاع', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _buildReason('تالف'),
              _buildReason('خاطئ'),
              _buildReason('غير مرغوب'),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تقديم طلب الإرجاع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReason(String r) => GestureDetector(
    onTap: () => setState(() => _reason = r),
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _reason == r ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _reason == r ? ShopColors.accent : ShopColors.border),
      ),
      child: Text(r, style: TextStyle(color: _reason == r ? ShopColors.accent : ShopColors.text)),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('طلب إرجاع', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
