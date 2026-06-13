import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SearchShopScreen extends StatefulWidget {
  const SearchShopScreen({super.key});

  @override
  State<SearchShopScreen> createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _ctrl, autofocus: true, style: const TextStyle(color: ShopColors.text), decoration: InputDecoration(hintText: 'ابحث في المتجر...', hintStyle: TextStyle(color: ShopColors.text2.withOpacity(0.5)), border: InputBorder.none))),
              ]),
            ),
            const Expanded(child: Center(child: Text('ابحث عن منتجات، متاجر، مزادات...', style: TextStyle(color: ShopColors.text2)))),
          ],
        ),
      ),
    );
  }
}
