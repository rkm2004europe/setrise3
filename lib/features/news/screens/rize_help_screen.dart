import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeHelpScreen extends StatelessWidget {
  const RizeHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Help Center', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ListTile(
                    leading: const Icon(Icons.question_answer, color: NewsColors.accent),
                    title: const Text('FAQs', style: TextStyle(color: NewsColors.textPrimary)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.support, color: NewsColors.accent),
                    title: const Text('Contact Support', style: TextStyle(color: NewsColors.textPrimary)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.flag, color: NewsColors.likeActive),
                    title: const Text('Report a Problem', style: TextStyle(color: NewsColors.textPrimary)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
