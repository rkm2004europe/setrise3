import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/draft_model.dart';

class DraftsScreen extends StatelessWidget {
  const DraftsScreen({super.key});

  // بيانات وهمية
  final List<DraftModel> _drafts = const [
    DraftModel(id: '1', caption: 'My awesome video draft', savedAt: _dummyDate),
    DraftModel(id: '2', caption: 'Product review #tech', savedAt: _dummyDate),
    DraftModel(id: '3', caption: 'Just thinking...', savedAt: _dummyDate),
  ];

  static const _dummyDate = null; // سيتم تجاهله في العرض

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Drafts',
                    style: TextStyle(
                      color: PostColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: PostColors.textSecondary),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _drafts.length,
                itemBuilder: (context, index) {
                  final draft = _drafts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: PostColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            draft.caption ?? 'No caption',
                            style: const TextStyle(color: PostColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: PostColors.textSecondary),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
