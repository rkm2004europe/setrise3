import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector({super.key});

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String _selected = 'cod';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر طريقة الدفع', style: TextStyle(color: ShopColors.text, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        _buildOption('cod', 'الدفع عند الاستلام', Icons.handshake),
        _buildOption('card', 'بطاقة ائتمان', Icons.credit_card),
        _buildOption('wallet', 'محفظة SetRise', Icons.account_balance_wallet),
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
