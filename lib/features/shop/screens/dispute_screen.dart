import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DisputeScreen extends StatelessWidget {
  const DisputeScreen({super.key});

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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('فتح نزاع', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  const Text('يرجى وصف المشكلة وسيتم مراجعتها من قبل فريق الدعم.', style: TextStyle(color: ShopColors.text2)),
                  const SizedBox(height: 12),
                  TextField(maxLines: 4, style: const TextStyle(color: ShopColors.text), decoration: InputDecoration(hintText: 'اشرح المشكلة...', hintStyle: TextStyle(color: ShopColors.text2.withOpacity(0.5)), filled: true, fillColor: ShopColors.bg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
                ]),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('إرسال', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('نظام النزاعات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
