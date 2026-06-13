import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AddReviewScreen extends StatefulWidget {
  final String productId;
  const AddReviewScreen({super.key, required this.productId});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _rating = 5;
  final _commentCtrl = TextEditingController();

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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Icon(i < _rating ? Icons.star : Icons.star_border, color: ShopColors.gold, size: 36),
              ))),
              const SizedBox(height: 20),
              TextField(
                controller: _commentCtrl,
                maxLines: 4,
                style: const TextStyle(color: ShopColors.text),
                decoration: InputDecoration(
                  hintText: 'اكتب تقييمك...',
                  hintStyle: TextStyle(color: ShopColors.text2.withOpacity(0.5)),
                  filled: true, fillColor: ShopColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () { Navigator.pop(context); },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('إرسال التقييم', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
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
    const Text('إضافة تقييم', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
