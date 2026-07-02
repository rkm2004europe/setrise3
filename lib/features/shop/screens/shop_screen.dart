// lib/features/shop/screens/shop_screen.dart
// نقطة الدخول لوحدة المتجر — Wrapper يغلّف ShopHomeScreen

import 'package:flutter/material.dart';
import 'shop_home_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) => const ShopHomeScreen();
}
