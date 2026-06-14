import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_freelance_services.dart';

class FreelanceServicesScreen extends StatelessWidget {
  const FreelanceServicesScreen({super.key});

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
                itemCount: mockFreelanceServices.length,
                itemBuilder: (_, i) {
                  final service = mockFreelanceServices[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16)),
                    child: Row(children: [
                      CircleAvatar(backgroundColor: ShopColors.accent.withOpacity(0.1), child: Text(service['icon']!, style: const TextStyle(fontSize: 22))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(service['name']!, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w700)),
                        Text(service['category']!, style: const TextStyle(color: ShopColors.text2, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text('\$${service['price']}', style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w600)),
                      ])),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(12)),
                          child: const Text('اطلب', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ]),
                  );
                },
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
      const Text('خدمات الفريلانس', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
