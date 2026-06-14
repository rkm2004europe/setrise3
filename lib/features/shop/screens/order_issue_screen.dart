import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OrderIssueScreen extends StatelessWidget {
  const OrderIssueScreen({super.key});

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
              _buildOption('لم يتم التسليم'),
              _buildOption('منتج تالف'),
              _buildOption('منتج خاطئ'),
            ],
          ),
        ),
      );
  }

  Widget _buildOption(String label) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Text(label, style: const TextStyle(color: ShopColors.text)),
      const Spacer(),
      const Icon(Icons.chevron_right, color: ShopColors.text2),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('مشكلة في الطلب', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
      }
