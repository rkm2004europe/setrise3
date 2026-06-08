import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_polls.dart';
import '../widgets/rize_poll_card.dart';

class PollsScreen extends StatelessWidget {
  const PollsScreen({super.key});

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
                  RizePollCard(poll: mockPoll),
                  const SizedBox(height: 16),
                  RizePollCard(poll: mockPoll),
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
            'Polls',
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
