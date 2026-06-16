import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TicketPurchaseScreen extends StatelessWidget {
  final String roomTitle;
  final double price;
  const TicketPurchaseScreen({super.key, required this.roomTitle, required this.price});

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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: LiveColors.gold.withOpacity(0.3))),
                child: Column(children: [
                  const Icon(Icons.confirmation_number, size: 64, color: LiveColors.gold),
                  const SizedBox(height: 12),
                  Text(roomTitle, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(color: LiveColors.accent, fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  const Text('تذكرة دخول لهذه الغرفة المميزة', style: TextStyle(color: LiveColors.text2)),
                ]),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('شراء التذكرة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
  ]);
}
