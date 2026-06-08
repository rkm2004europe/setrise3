import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/rize_draft_card.dart';
import '../models/rize_post_model.dart';

class RizeDraftsScreen extends StatefulWidget {
  const RizeDraftsScreen({super.key});

  @override
  State<RizeDraftsScreen> createState() => _RizeDraftsScreenState();
}

class _RizeDraftsScreenState extends State<RizeDraftsScreen> {
  final List<RizePostModel> _drafts = [];

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
                  const Text('Drafts', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: _drafts.isEmpty
                  ? const Center(child: Text('No drafts', style: TextStyle(color: NewsColors.textSecondary)))
                  : ListView.builder(
                      itemCount: _drafts.length,
                      itemBuilder: (context, index) => RizeDraftCard(
                        draft: _drafts[index],
                        onEdit: () {},
                        onDelete: () {
                          setState(() => _drafts.removeAt(index));
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
