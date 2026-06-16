import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_coins.dart';

class CoinShopScreen extends StatelessWidget {
  const CoinShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              const Text('رصيدي: 250 🪙', style: TextStyle(color: LiveColors.gold, fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: coinPackages.map((pack) {
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم شراء ${pack['coins']} عملة'),
                            backgroundColor: LiveColors.accent,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: LiveColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: LiveColors.gold.withOpacity(0.3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${pack['coins']}', style: const TextStyle(color: LiveColors.text, fontSize: 28, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 4),
                            const Text('🪙', style: TextStyle(fontSize: 24)),
                            const SizedBox(height: 8),
                            Text('\$${pack['price']}', style: const TextStyle(color: LiveColors.accent, fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: LiveColors.text),
          ),
          const SizedBox(width: 12),
          const Text('شراء العملات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
