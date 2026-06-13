import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NotificationShopScreen extends StatelessWidget {
  const NotificationShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  ListTile(leading: Icon(Icons.notifications, color: ShopColors.accent), title: Text('تخفيضات جديدة!', style: TextStyle(color: ShopColors.text)), subtitle: Text('خصم 50% على الإلكترونيات', style: TextStyle(color: ShopColors.text2))),
                  ListTile(leading: Icon(Icons.local_offer, color: ShopColors.green), title: Text('شحن مجاني', style: TextStyle(color: ShopColors.text)), subtitle: Text('للطلبات فوق 100 دج', style: TextStyle(color: ShopColors.text2))),
                ],
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
      const Text('الإشعارات', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
