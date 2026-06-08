import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_post_model.dart';
import '../data/mock_rize_posts.dart';
import '../data/trending_hashtags.dart';
import 'rize_post_card.dart';
import 'create_rize_screen.dart';

class RizeFeedScreen extends StatefulWidget {
  const RizeFeedScreen({super.key});

  @override
  State<RizeFeedScreen> createState() => _RizeFeedScreenState();
}

class _RizeFeedScreenState extends State<RizeFeedScreen> {
  late List<RizePostModel> _posts;

  @override
  void initState() {
    super.initState();
    _posts = generateMockRizePosts();
  }

  void _updatePost(int index, RizePostModel updatedPost) {
    setState(() => _posts[index] = updatedPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط علوي مخصص
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text(
                    'Rize',
                    style: TextStyle(
                      color: NewsColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateRizeScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: NewsColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add,
                          color: NewsColors.textPrimary, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            // شريط الهاشتاغات الرائجة
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: trendingHashtags.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    // TODO: filter by hashtag
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: NewsColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: NewsColors.border),
                    ),
                    child: Text(
                      trendingHashtags[index],
                      style: const TextStyle(
                        color: NewsColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: NewsColors.divider),
            // Feed
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // محاكاة التحديث
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {
                    _posts = generateMockRizePosts();
                  });
                },
                child: ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) => RizePostCard(
                    post: _posts[index],
                    onUpdate: (updated) => _updatePost(index, updated),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
