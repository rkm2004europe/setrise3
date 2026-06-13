import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DeliveryOptionSelector extends StatefulWidget {
  const DeliveryOptionSelector({super.key});

  @override
  State<DeliveryOptionSelector> createState() => _DeliveryOptionSelectorState();
}

class _DeliveryOptionSelectorState extends State<DeliveryOptionSelector> {
  String _selected = 'standard';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('خيار التوصيل', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        _buildOption('standard', 'توصيل عادي (3-5 أيام)', Icons.local_shipping),
        _buildOption('express', 'توصيل سريع (يوم واحد)', Icons.flash_on),
      ],
    );
  }

  Widget _buildOption(String value, String title, IconData icon) => GestureDetector(
    onTap: () => setState(() => _selected = value),
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _selected == value ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _selected == value ? ShopColors.accent : ShopColors.border),
      ),
      child: Row(children: [
        Icon(icon, color: _selected == value ? ShopColors.accent : ShopColors.text2),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: _selected == value ? ShopColors.accent : ShopColors.text, fontWeight: FontWeight.w600)),
        const Spacer(),
        if (_selected == value) const Icon(Icons.check_circle, color: ShopColors.accent),
      ]),
    ),
  );
}
