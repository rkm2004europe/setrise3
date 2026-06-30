import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WalletTransferScreen extends StatelessWidget {
  const WalletTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              TextField(style: const TextStyle(color: LiveColors.text), decoration: InputDecoration(hintText: 'معرف المستخدم', hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)), filled: true, fillColor: LiveColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 12),
              TextField(keyboardType: TextInputType.number, style: const TextStyle(color: LiveColors.text), decoration: InputDecoration(hintText: 'المبلغ', hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)), filled: true, fillColor: LiveColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تحويل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('تحويل عملات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
