// lib/features/shop/screens/widgets/banner_section.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [ShopColors.accent, ShopColors.accent.withOpacity(0.6)]),
        ),
        child: Stack(children: [
          Positioned(right: -10, bottom: -10,
            child: Icon(CupertinoIcons.gift,
              size: 120, color: Colors.white.withOpacity(0.1))),
          Padding(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Special Offer', style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Up to 50% off', style: TextStyle(
                color: Colors.white, fontSize: 14)),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                onPressed: () {},
                child: const Text('Shop Now', style: TextStyle(
                  color: ShopColors.accent, fontWeight: FontWeight.w600)),
              ),
            ])),
        ]),
      ),
    );
  }
}

