import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/rize_voice_card.dart';
import '../models/rize_voice_model.dart';

class VoiceRizeScreen extends StatelessWidget {
  const VoiceRizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  RizeVoiceCard(
                    title: 'My first voice Rize 🎙️',
                    duration: const Duration(seconds: 45),
                  ),
                  const SizedBox(height: 12),
                  RizeVoiceCard(
                    title: 'Morning thoughts',
                    duration: const Duration(seconds: 120),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            'Voice Rize',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
