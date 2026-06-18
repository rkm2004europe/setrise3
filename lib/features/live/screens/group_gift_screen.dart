import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_group_gifts.dart';
import '../widgets/group_gift_progress.dart';

class GroupGiftScreen extends StatelessWidget {
  const GroupGiftScreen({super.key});

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
                itemCount: mockGroupGifts.length,
                itemBuilder: (_, i) => GroupGiftProgress(gift: mockGroupGifts[i]),
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
      const Text('الهدايا الجماعية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
