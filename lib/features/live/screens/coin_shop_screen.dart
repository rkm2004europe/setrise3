import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_coins.dart';
import '../widgets/coin_package_card.dart';

class CoinShopScreen extends StatelessWidget {
  const CoinShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 12),
            // الرصيد الحالي
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [LiveColors.gold.withOpacity(0.3), LiveColors.bg],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: LiveColors.gold.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: LiveColors.gold, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('رصيدك الحالي', style: TextStyle(color: LiveColors.text2, fontSize: 12)),
                      Text('$mockUserCoins 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 28, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('اختر الحزمة', style: TextStyle(color: LiveColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: coinPackages.length,
                itemBuilder: (_, i) {
                  final pkg = coinPackages[i];
                  return CoinPackageCard(
                    coins: pkg['coins'] as int,
                    price: (pkg['price'] as num).toDouble(),
                    onBuy: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم شراء ${pkg['coins']} عملة!'),
                          backgroundColor: LiveColors.gold,
                        ),
                      );
                    },
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('متجر العملات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
