import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BundlesScreen extends StatelessWidget {
  const BundlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 4,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(['📱+🎧', '👟+👕', '⌚+📷', '💻+🖱️'][i], style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('حزمة ${i+1}', style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                        Text('وفر 15%', style: const TextStyle(color: ShopColors.green)),
                      ]),
                      const Spacer(),
                      Text('\$${99 + i*50}', style: const TextStyle(color: ShopColors.accent, fontSize: 18, fontWeight: FontWeight.w800)),
                    ]),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)), child: const Center(child: Text('أضف للسلة', style: TextStyle(color: Colors.white)))),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('الحزم', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
