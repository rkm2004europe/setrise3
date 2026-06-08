import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_posts.dart';
import '../widgets/rize_post_card.dart';
import '../models/rize_post_model.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late List<RizePostModel> _bookmarkedPosts;

  @override
  void initState() {
    super.initState();
    _bookmarkedPosts = generateMockRizePosts().where((p) => p.isBookmarked).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: _bookmarkedPosts.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bookmark_border, color: NewsColors.textSecondary, size: 48),
                          SizedBox(height: 12),
                          Text('No bookmarks yet', style: TextStyle(color: NewsColors.textSecondary)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _bookmarkedPosts.length,
                      itemBuilder: (context, index) => RizePostCard(
                        post: _bookmarkedPosts[index],
                        onUpdate: (updated) {
                          setState(() {
                            _bookmarkedPosts[index] = updated;
                            if (!updated.isBookmarked) {
                              _bookmarkedPosts.removeAt(index);
                            }
                          });
                        },
                      ),
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
            'Bookmarks',
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
