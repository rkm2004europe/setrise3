import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  final _emailCtrl = TextEditingController();
  int _amount = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: [50, 100, 200, 500].map((v) => GestureDetector(
                  onTap: () => setState(() => _amount = v),
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _amount == v ? ShopColors.accent : ShopColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _amount == v ? ShopColors.accent : ShopColors.border),
                    ),
                    child: Center(child: Text('\$$v', style: TextStyle(color: _amount == v ? Colors.white : ShopColors.text, fontWeight: FontWeight.w800))),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailCtrl,
                style: const TextStyle(color: ShopColors.text),
                decoration: InputDecoration(hintText: 'بريد المستلم', hintStyle: TextStyle(color: ShopColors.text2.withOpacity(0.5)), filled: true, fillColor: ShopColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('شراء وإرسال', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('بطاقات الهدايا', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
