// lib/features/shop/screens/auction/offers_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  static const _coupons = [
    {'code': 'WELCOME10', 'desc': '10% off your first order'},
    {'code': 'SAVE50',    'desc': '\$50 off orders over \$200'},
    {'code': 'FREESHIP',  'desc': 'Free shipping on any order'},
    {'code': 'FLASH25',   'desc': '25% off flash deals'},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text('Coupons & Offers',
          style: TextStyle(color: CupertinoColors.white))),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _coupons.length,
          itemBuilder: (_, i) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ShopColors.surface,
              borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: ShopColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
                child: const Icon(CupertinoIcons.ticket,
                  color: ShopColors.accent)),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_coupons[i]['code']!, style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
                Text(_coupons[i]['desc']!, style: const TextStyle(
                  color: ShopColors.grey, fontSize: 13)),
              ])),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Text('Claim',
                  style: TextStyle(color: ShopColors.accent))),
            ])),
        ),
      ),
    );
  }
}

