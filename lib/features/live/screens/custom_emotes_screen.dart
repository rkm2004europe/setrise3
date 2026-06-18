import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomEmotesScreen extends StatelessWidget {
  const CustomEmotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(16),
                children: List.generate(12, (i) => Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: LiveColors.surface,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(['😂', '❤️', '🔥', '👍', '😍', '🎉', '😢', '😡', '🥳', '👏', '💪', '🤩'][i],
                              style: const TextStyle(fontSize: 28))),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
            const SizedBox(width: 12),
            const Text('الرموز التعبيرية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
