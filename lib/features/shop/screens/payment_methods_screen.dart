import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_payment_methods.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _selected = 'cod';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockPaymentMethods.length,
                itemBuilder: (_, i) {
                  final method = mockPaymentMethods[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selected = method['id']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selected == method['id'] ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _selected == method['id'] ? ShopColors.accent : ShopColors.border),
                      ),
                      child: Row(children: [
                        Icon(method['icon'] as IconData, color: _selected == method['id'] ? ShopColors.accent : ShopColors.text2),
                        const SizedBox(width: 12),
                        Text(method['name'] as String, style: TextStyle(color: _selected == method['id'] ? ShopColors.accent : ShopColors.text, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        if (_selected == method['id']) const Icon(Icons.check_circle, color: ShopColors.accent),
                      ]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تأكيد طريقة الدفع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('طرق الدفع', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
