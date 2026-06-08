import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../widgets/rize_quote_card.dart';

class RizeRepostScreen extends StatefulWidget {
  final RizePostModel originalPost;
  const RizeRepostScreen({super.key, required this.originalPost});

  @override
  State<RizeRepostScreen> createState() => _RizeRepostScreenState();
}

class _RizeRepostScreenState extends State<RizeRepostScreen> {
  final _commentCtrl = TextEditingController();
  bool _isPublishing = false;

  Future<void> _repost() async {
    setState(() => _isPublishing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reposted!'), backgroundColor: NewsColors.repost),
    );
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
                  GestureDetector(
                    onTap: _repost,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: NewsColors.repost,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Repost', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _commentCtrl,
                maxLines: 4,
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
