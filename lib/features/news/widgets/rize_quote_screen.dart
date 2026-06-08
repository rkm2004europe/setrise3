import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../widgets/rize_quote_card.dart';

class RizeQuoteScreen extends StatefulWidget {
  final RizePostModel originalPost;
  const RizeQuoteScreen({super.key, required this.originalPost});

  @override
  State<RizeQuoteScreen> createState() => _RizeQuoteScreenState();
}

class _RizeQuoteScreenState extends State<RizeQuoteScreen> {
  final _commentCtrl = TextEditingController();

  void _publishQuote() {
    // خدمة النشر ستضاف لاحقًا
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quote published!'), backgroundColor: NewsColors.accent),
    );
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: NewsColors.textPrimary),
                  ),
                  const Spacer(),
                  const Text('Quote Rize', style: TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _publishQuote,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: NewsColors.accent, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Quote', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _commentCtrl,
                maxLines: 4,
                maxLength: 250,
                style: const TextStyle(color: NewsColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: TextStyle(color: NewsColors.textSecondary.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              RizeQuoteCard(post: widget.originalPost),
            ],
          ),
        ),
      ),
    );
  }
}
