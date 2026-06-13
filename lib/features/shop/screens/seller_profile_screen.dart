import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SellerProfileScreen extends StatelessWidget {
  final String sellerName;
  final double rating;
  final int productCount;
  final int followers;

  const SellerProfileScreen({
    super.key,
    required this.sellerName,
    required this.rating,
    required this.productCount,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            const CircleAvatar(radius: 50, backgroundColor: ShopColors.surface, child: Icon(Icons.store, size: 50, color: ShopColors.accent)),
            const SizedBox(height: 12),
            Text(sellerName, style: const TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.star, color: ShopColors.gold, size: 18),
              const SizedBox(width: 4),
              Text('$rating', style: const TextStyle(color: ShopColors.text)),
              const SizedBox(width: 16),
              Text('$productCount منتج', style: const TextStyle(color: ShopColors.text2)),
              const SizedBox(width: 16),
              Text('$followers متابع', style: const TextStyle(color: ShopColors.text2)),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildActionButton('متابعة', Icons.person_add, () {}),
              const SizedBox(width: 16),
              _buildActionButton('مراسلة', Icons.message, () {}),
            ]),
            const SizedBox(height: 20),
            const Divider(color: ShopColors.border),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75),
                itemCount: productCount,
                itemBuilder: (_, i) => Container(
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text('منتج ${i+1}', style: const TextStyle(color: ShopColors.text))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ]),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    ]),
  );
}
