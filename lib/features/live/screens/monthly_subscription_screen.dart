import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MonthlySubscriptionScreen extends StatefulWidget {
  const MonthlySubscriptionScreen({super.key});

  @override
  State<MonthlySubscriptionScreen> createState() => _MonthlySubscriptionScreenState();
}

class _MonthlySubscriptionScreenState extends State<MonthlySubscriptionScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _plan('أساسي', 4.99, 'رموز تعبيرية حصرية', 0),
              _plan('مميز', 9.99, 'هدية شهرية + شارة VIP', 1),
              _plan('أسطوري', 19.99, 'كل المزايا + مدير غرفة', 2),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('اشترك الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plan(String name, double price, String desc, int index) => GestureDetector(
    onTap: () => setState(() => _selected = index),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _selected == index ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _selected == index ? LiveColors.accent : LiveColors.border),
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
          Text(desc, style: const TextStyle(color: LiveColors.text2)),
        ])),
        Text('\$$price/شهر', style: const TextStyle(color: LiveColors.gold, fontWeight: FontWeight.w800)),
      ]),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('الاشتراكات الشهرية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
