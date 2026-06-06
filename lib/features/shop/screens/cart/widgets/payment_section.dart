// lib/features/shop/screens/cart/widgets/payment_section.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class PaymentSection extends StatelessWidget {
  final List<PaymentMethod> methods;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const PaymentSection({
    super.key, required this.methods,
    required this.selectedIndex, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(methods.length, (i) {
        final m = methods[i];
        final isSelected = i == selectedIndex;
        return GestureDetector(
          onTap: () => onChanged(i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                ? ShopColors.accent.withOpacity(0.2)
                : ShopColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                  ? ShopColors.accent
                  : ShopColors.grey.withOpacity(0.3))),
            child: Row(children: [
              Icon(
                isSelected
                  ? CupertinoIcons.check_mark_circled
                  : CupertinoIcons.circle,
                color: isSelected ? ShopColors.accent : ShopColors.grey2),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.name, style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
                Text(m.details, style: const TextStyle(
                  color: ShopColors.grey2, fontSize: 12)),
              ])),
            ])));
      }));
  }
}

