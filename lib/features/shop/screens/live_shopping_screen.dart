import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveShoppingScreen extends StatefulWidget {
  const LiveShoppingScreen({super.key});

  @override
  State<LiveShoppingScreen> createState() => _LiveShoppingScreenState();
}

class _LiveShoppingScreenState extends State<LiveShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Stack(
                children: [
                  Container(color: ShopColors.surface, child: const Center(child: Icon(Icons.live_tv, size: 120, color: ShopColors.accent))),
                  Positioned(
                    bottom: 16, left: 16, right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: ShopColors.bg.withOpacity(0.8), borderRadius: BorderRadius.circular(14)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          const Text('بث مباشر', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          const Text('1.2K مشاهدة', style: TextStyle(color: ShopColors.text2)),
                        ]),
                        const SizedBox(height: 8),
                        const Text('منتج اليوم: ساعة ذكية', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                        const Text('\$199 فقط اليوم', style: TextStyle(color: ShopColors.accent)),
                      ]),
                    ),
                  ),
                ],
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
      const Text('تسوق مباشر', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
