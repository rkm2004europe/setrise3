import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.check_circle, color: ShopColors.green, size: 80),
              const SizedBox(height: 20),
              const Text('تم تأكيد الطلب!', style: TextStyle(color: ShopColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text('رقم الطلب: $orderId', style: const TextStyle(color: ShopColors.text2)),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Text('العودة للمتجر', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
