import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_monetization.dart';

class MonetizationScreen extends StatelessWidget {
  const MonetizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Monetization', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.amber.withOpacity(0.3), NewsColors.surface]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 10),
                        Text('\$${mockMonetization.totalEarnings.toStringAsFixed(2)}',
                            style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w900, fontSize: 28)),
                        const Text('Total Earnings', style: TextStyle(color: NewsColors.textSecondary)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat('Impressions', mockMonetization.impressions.toString()),
                            _buildStat('CPM', '\$${mockMonetization.cpm.toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
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

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w900, fontSize: 18)),
        Text(label, style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
      ],
    );
  }
}
