import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'post_card.dart';
import '../models/post_model.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({super.key});

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<PostModel> _posts = PostModel.getMockPosts();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updatePost(int index, PostModel updatedPost) {
    setState(() => _posts[index] = updatedPost);
  }

  void _goNextPage() {
    if (_currentPage < _posts.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _posts.length,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (i) => setState(() => _currentPage = i),
      itemBuilder: (ctx, i) => PostCard(
        post: _posts[i],
        onUpdate: (p) => _updatePost(i, p),
        onSwipeNext: _goNextPage,
        onSwipeRight: () => HapticFeedback.mediumImpact(),
        onSwipeLeft: () => HapticFeedback.lightImpact(),
        onSwipeStart: () {},
        onSwipeEnd: () {},
      ),
    );
  }
}
