import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/trending_topics.dart';

class SearchRizeScreen extends StatefulWidget {
  const SearchRizeScreen({super.key});

  @override
  State<SearchRizeScreen> createState() => _SearchRizeScreenState();
}

class _SearchRizeScreenState extends State<SearchRizeScreen> {
  final _searchCtrl = TextEditingController();

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
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      autofocus: true,
                      style: const TextStyle(color: NewsColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Search Rize...',
                        hintStyle: TextStyle(color: NewsColors.textSecondary.withOpacity(0.5)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const Text(
                    'Trending',
                    style: TextStyle(
                      color: NewsColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...trendingTopics.map((topic) => ListTile(
                        leading: const Icon(Icons.trending_up, color: NewsColors.accent),
                        title: Text(topic.title, style: const TextStyle(color: NewsColors.textPrimary)),
                        subtitle: Text('${topic.postsCount} posts', style: const TextStyle(color: NewsColors.textSecondary)),
                        onTap: () {},
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
