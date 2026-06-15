import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildListCard('تجهيزات العيد', 8),
                  _buildListCard('مستلزمات المكتب', 5),
                  _buildListCard('هدايا العائلة', 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(String name, int count) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      const Icon(Icons.list_alt, color: ShopColors.accent),
      const SizedBox(width: 12),
      Expanded(child: Text(name, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600))),
      Text('$count منتجات', style: const TextStyle(color: ShopColors.text2)),
      const Icon(Icons.chevron_right, color: ShopColors.text2),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('قوائم التسوق', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
