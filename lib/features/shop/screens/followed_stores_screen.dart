import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_followed_stores.dart';

class FollowedStoresScreen extends StatelessWidget {
  const FollowedStoresScreen({super.key});

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
                itemCount: mockFollowedStores.length,
                itemBuilder: (_, i) {
                  final store = mockFollowedStores[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
                    child: Row(children: [
                      CircleAvatar(backgroundColor: ShopColors.accent.withOpacity(0.1), child: Icon(Icons.store, color: ShopColors.accent)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(store['name']!, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                        Text('${store['products']} منتج', style: const TextStyle(color: ShopColors.text2)),
                      ])),
                      const Icon(Icons.chevron_right, color: ShopColors.text2),
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
      const Text('المتاجر المتابعة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
