import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MultiGuestScreen extends StatelessWidget {
  const MultiGuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const Expanded(child: Center(child: Text('ما يصل إلى 4 ضيوف', style: TextStyle(color: LiveColors.text2)))),
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
      const Text('بث مع ضيوف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
