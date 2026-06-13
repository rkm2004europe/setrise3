import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FoodDeliveryScreen extends StatelessWidget {
  const FoodDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                  child: Row(children: [
                    Text(['🍕', '🍔', '🍣', '🥗', '🍰', '☕'][i], style: const TextStyle(fontSize: 40)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(['بيتزا', 'برغر', 'سوشي', 'سلطة', 'كيك', 'قهوة'][i], style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700))),
                    const Text('25 دقيقة', style: TextStyle(color: ShopColors.text2)),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('الطعام والتوصيل', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
