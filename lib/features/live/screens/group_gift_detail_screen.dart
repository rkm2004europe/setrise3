Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/group_gift_progress.dart';
import '../data/mock_group_gifts.dart';

class GroupGiftDetailScreen extends StatefulWidget {
  const GroupGiftDetailScreen({super.key});

  @override
  State<GroupGiftDetailScreen> createState() => _GroupGiftDetailScreenState();
}

class _GroupGiftDetailScreenState extends State<GroupGiftDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Text('الهدايا الجماعية', style: const TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: mockGroupGifts.length,
                  itemBuilder: (_, i) => GroupGiftProgress(gift: mockGroupGifts[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('الهدايا الجماعية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
