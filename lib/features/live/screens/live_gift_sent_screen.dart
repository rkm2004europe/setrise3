import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveGiftSentScreen extends StatelessWidget {
  const LiveGiftSentScreen({super.key});

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
              const Spacer(),
              const Icon(Icons.check_circle, size: 80, color: LiveColors.gold),
              const SizedBox(height: 20),
              const Text('تم إرسال الهدية!', style: TextStyle(color: LiveColors.gold, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text('🚗 سيارة', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text('50 🪙', style: TextStyle(color: LiveColors.gold, fontSize: 18)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('عودة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('إرسال هدية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
