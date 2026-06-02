// lib/features/news/screens/news_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/news/models/news_post_model.dart';
import 'package:setrise/features/news/screens/widgets/news_post_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollCtrl;
  late final TabController    _tabCtrl;
  final List<NewsPostModel>   _posts = NewsPostModel.getMockPosts();
  int  _tabIndex     = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollCtrl = ScrollController()..addListener(_onScroll);
    _tabCtrl    = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _tabCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    final pos = _scrollCtrl.position;
    if (pos.pixels >= pos.maxScrollExtent - 320) _loadMore();
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _posts.addAll(NewsPostModel.getMockPosts().map((p) =>
          p.copyWith(id: '${DateTime.now().millisecondsSinceEpoch}_${p.id}')));
      _isLoadingMore = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _tabIndex = _tabCtrl.index);
  }

  List<NewsPostModel> get _visible {
    if (_tabIndex == 1) {
      final f = _posts.where((p) => p.isFollowing).toList();
      return f.isEmpty ? _posts : f;
    }
    return _posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        color: const Color(0xFF007AFF),
        backgroundColor: const Color(0xFF121212),
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollCtrl,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            // ── Header ────────────────────────────────────
            SliverAppBar(
              backgroundColor: Colors.black,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 0,
              collapsedHeight: 0,
              floating: true, snap: true, pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 110,
              flexibleSpace: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Search Bar
                    GestureDetector(
                      onTap: () => HapticFeedback.lightImpact(),
                      child: Container(height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.white.withOpacity(0.08))),
                        child: Row(children: [
                          Icon(CupertinoIcons.search,
                            color: Colors.white.withOpacity(0.45), size: 18),
                          const SizedBox(width: 8),
                          Text('Search Rize...',
                            style: TextStyle(color: Colors.white.withOpacity(0.35),
                              fontSize: 14, fontFamily: 'Inter')),
                        ])),
                    ),
                    const SizedBox(height: 12),
                    // Tabs
                    Container(height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.06))),
                      child: Row(
                        children: ['For You', 'Following'].asMap().entries.map((e) {
                          final selected = _tabIndex == e.key;
                          return Expanded(child: GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              _tabCtrl.animateTo(e.key);
                              setState(() => _tabIndex = e.key);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: selected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(11)),
                              child: Center(child: Text(e.value,
                                style: TextStyle(
                                  color: selected ? Colors.black : Colors.white54,
                                  fontSize: 13, fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter'))))));
                        }).toList(),
                      )),
                  ])),
              ),
            ),

            // ── Posts List ────────────────────────────────
            SliverList(delegate: SliverChildBuilderDelegate(
              (_, i) {
                if (i >= _visible.length) {
                  return _isLoadingMore
                      ? const Padding(padding: EdgeInsets.symmetric(vertical: 22),
                          child: Center(child: CupertinoActivityIndicator()))
                      : const SizedBox.shrink();
                }
                final post = _visible[i];
                return NewsPostCard(
                  key: ValueKey(post.id),
                  post: post,
                  // ✅ التعليقات والمشاركة مربوطة داخل NewsPostCard
                  onUpdate: (updated) => setState(() => _posts[i] = updated),
                );
              },
              childCount: _visible.length + 1,
            )),

            const SliverToBoxAdapter(
              child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

