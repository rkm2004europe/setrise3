import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QnaScreen extends StatelessWidget {
  final String productId;
  const QnaScreen({super.key, required this.productId});

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
                  ListTile(leading: Icon(Icons.question_answer, color: ShopColors.accent), title: Text('هل يدعم الشحن الدولي؟', style: TextStyle(color: ShopColors.text)), subtitle: Text('نعم، الشحن متاح لكل الدول.', style: TextStyle(color: ShopColors.text2))),
                  ListTile(leading: Icon(Icons.question_answer, color: ShopColors.accent), title: Text('ما هي مدة الضمان؟', style: TextStyle(color: ShopColors.text)), subtitle: Text('سنة كاملة ضد عيوب التصنيع.', style: TextStyle(color: ShopColors.text2))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(child: TextField(style: const TextStyle(color: ShopColors.text), decoration: InputDecoration(hintText: 'اسأل عن هذا المنتج...', hintStyle: TextStyle(color: ShopColors.text2.withOpacity(0.5)), filled: true, fillColor: ShopColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))),
                const SizedBox(width: 10),
                GestureDetector(onTap: () {}, child: Container(width: 48, height: 48, decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.send, color: Colors.white))),
              ]),
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
      const Text('الأسئلة والأجوبة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
