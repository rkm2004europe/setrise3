import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DisputeCenterScreen extends StatelessWidget {
  const DisputeCenterScreen({super.key});

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
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(14)),
                child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('الشكاوى والطعون', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('يمكنك تقديم شكوى أو طعن على قرار.', style: TextStyle(color: LiveColors.text2)),
                ]),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تقديم شكوى', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('مركز الشكاوى', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
