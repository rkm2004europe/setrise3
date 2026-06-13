import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_delivery_addresses.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  String _selected = 'add1';

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
                itemCount: mockAddresses.length,
                itemBuilder: (_, i) {
                  final addr = mockAddresses[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selected = addr['id']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _selected == addr['id'] ? ShopColors.accent.withOpacity(0.1) : ShopColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _selected == addr['id'] ? ShopColors.accent : ShopColors.border),
                      ),
                      child: Row(children: [
                        Icon(Icons.location_on, color: _selected == addr['id'] ? ShopColors.accent : ShopColors.text2),
                        const SizedBox(width: 12),
                        Expanded(child: Text(addr['address']!, style: TextStyle(color: _selected == addr['id'] ? ShopColors.accent : ShopColors.text))),
                        if (_selected == addr['id']) const Icon(Icons.check_circle, color: ShopColors.accent),
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
                  child: const Center(child: Text('تأكيد العنوان', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
      const Text('عنوان التوصيل', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
