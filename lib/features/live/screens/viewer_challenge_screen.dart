import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_viewer_challenges.dart';
import '../widgets/challenge_progress_bar.dart';

class ViewerChallengeScreen extends StatelessWidget {
  const ViewerChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockViewerChallenges.length,
                itemBuilder: (_, i) {
                  final ch = mockViewerChallenges[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(ch.description, style: const TextStyle(color: LiveColors.text)),
                      const SizedBox(height: 8),
                      ChallengeProgressBar(current: ch.acceptedBy.length, total: 10),
                    ]),
                  );
                },
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
      const Text('تحديات المشاهدين', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
