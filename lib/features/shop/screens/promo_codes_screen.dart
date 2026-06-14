import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_coupons.dart';

class PromoCodesScreen extends StatelessWidget {
  const PromoCodesScreen({super.key});

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
                itemCount: mockCoupons.length,
                itemBuilder: (_, i) {
                  final c = mockCoupons[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: c['active'] == true ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ShopColors.border),
                    ),
                    child: Row(children: [
                      const Icon(Icons.card_giftcard, color: ShopColors.accent),
                      const SizedBox(width: 12),
                      Expanded(child: Text(c['code'] as String, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600))),
                      Text('خصم ${c['discount']}%', style: const TextStyle(color: ShopColors.accent)),
                    ]),
                  );
                },
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
      const Text('أكواد الخصم', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
