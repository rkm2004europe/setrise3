import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gift_bundle_offer.dart';

class GiftBundleShopScreen extends StatelessWidget {
  const GiftBundleShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GiftBundleOffer(bundleName: 'باقة البداية', coinPrice: 50, gifts: ['🌹', '❤️'], onBuy: () {}),
                  GiftBundleOffer(bundleName: 'باقة النجومية', coinPrice: 200, gifts: ['🚗', '👑'], onBuy: () {}),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('باقات الهدايا', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
