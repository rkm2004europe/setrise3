import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveReplayScreen extends StatelessWidget {
  final String title;
  const LiveReplayScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.replay, size: 64, color: LiveColors.text2),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('إعادة البث مع الدردشة', style: TextStyle(color: LiveColors.text2)),
                ]),
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
      const Text('إعادة البث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
