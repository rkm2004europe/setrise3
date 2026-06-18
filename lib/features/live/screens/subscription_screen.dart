import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_subscriptions.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockSubscriptions.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1)),
                  title: Text(mockSubscriptions[i].hostId, style: const TextStyle(color: LiveColors.text)),
                  subtitle: Text('\$${mockSubscriptions[i].monthlyPrice}/شهر', style: const TextStyle(color: LiveColors.text2)),
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('الاشتراكات', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
