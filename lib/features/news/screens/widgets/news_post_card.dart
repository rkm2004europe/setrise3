// lib/features/news/screens/widgets/news_post_card.dart
//
// ✅ مربوط بـ:
//   - CommentsScreen  → عند الضغط على التعليقات
//   - ShareSheet      → عند الضغط على المشاركة
//   - UserPreviewSheet → عند الضغط على اسم المستخدم

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/news/models/news_post_model.dart';
import 'package:setrise/features/comment/screens/comments_screen.dart';
import 'package:setrise/features/comment/models/comment_model.dart';
import 'package:setrise/features/shar/screens/widgets/share_sheet.dart';
import 'package:setrise/features/user/screens/widgets/user_preview_sheet.dart';

class NewsPostCard extends StatefulWidget {
  final NewsPostModel post;
  final Function(NewsPostModel) onUpdate;

  const NewsPostCard({super.key, required this.post, required this.onUpdate});

  @override
  State<NewsPostCard> createState() => _NewsPostCardState();
}

class _NewsPostCardState extends State<NewsPostCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _likeCtrl;
  late final Animation<double> _likeScale;
  bool _showFullBody = false;

  static const Color _accent = Color(0xFF007AFF);

  @override
  void initState() {
    super.initState();
    _likeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _likeScale = Tween<double>(begin: 1.0, end: 1.18).animate(
        CurvedAnimation(parent: _likeCtrl, curve: Curves.easeOutBack));
  }

  @override
  void dispose() { _likeCtrl.dispose(); super.dispose(); }

  // ── Interactions ─────────────────────────────────────────
  void _toggleUpvote() {
    HapticFeedback.selectionClick();
    _likeCtrl.forward().then((_) => _likeCtrl.reverse());
    widget.onUpdate(widget.post.copyWith(
      isUpvoted: !widget.post.isUpvoted,
      upvotes: widget.post.isUpvoted
          ? widget.post.upvotes - 1
          : widget.post.upvotes + 1,
    ));
  }

  void _toggleBookmark() {
    HapticFeedback.selectionClick();
    widget.onUpdate(widget.post.copyWith(isBookmarked: !widget.post.isBookmarked));
  }

  void _toggleFollow() {
    HapticFeedback.selectionClick();
    widget.onUpdate(widget.post.copyWith(isFollowing: !widget.post.isFollowing));
  }

  // ── ✅ التعليقات → CommentsScreen ─────────────────────────
  void _openComments() {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: CommentsScreen(
          contextId: widget.post.id,
          contextName: widget.post.username,
          contextType: CommentContextType.post,
          accent: _accent,
        ),
      ),
    );
  }

  // ── ✅ المشاركة → ShareSheet ──────────────────────────────
  void _openShare() {
    HapticFeedback.selectionClick();
    showShareSheet(context,
      post: SharePostData(
        postId: widget.post.id,
        authorName: widget.post.name,
        authorUsername: widget.post.username,
        content: widget.post.body,
        accentColor: _accent,
      ));
    widget.onUpdate(widget.post.copyWith(shares: widget.post.shares + 1));
  }

  // ── ✅ بروفيل المستخدم → UserPreviewSheet ─────────────────
  void _openUserProfile() {
    showUserPreviewSheet(context,
      userId: widget.post.userId,
      userName: widget.post.name,
      username: widget.post.username,
      isFollowing: widget.post.isFollowing,
      accent: _accent,
      onViewProfile: () {
        // TODO: navigate to profile
      });
  }

  // ── More Options ─────────────────────────────────────────
  void _showMore() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () { Navigator.pop(context); _toggleBookmark(); },
            child: Text(widget.post.isBookmarked ? 'Remove Bookmark' : 'Bookmark')),
          CupertinoActionSheetAction(
            onPressed: () { Navigator.pop(context); _toggleFollow(); },
            child: Text(widget.post.isFollowing ? 'Unfollow' : 'Follow')),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Copy Link')),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Report')),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel')),
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  String _timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inDays >= 365) return '${diff.inDays ~/ 365}y';
    if (diff.inDays >= 30)  return '${diff.inDays ~/ 30}mo';
    if (diff.inDays > 0)    return '${diff.inDays}d';
    if (diff.inHours > 0)   return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }

  @override
  Widget build(BuildContext context) {
    final body = widget.post.body;
    final isLong = body.length > 200;
    final displayBody = (!_showFullBody && isLong)
        ? '${body.substring(0, 200)}...'
        : body;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Header ──────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ✅ Avatar — قابل للضغط
            GestureDetector(
              onTap: _openUserProfile,
              child: Container(width: 42, height: 42,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
                child: Center(child: Text(widget.post.userAvatar,
                  style: const TextStyle(fontSize: 20)))),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ✅ الاسم — قابل للضغط
              GestureDetector(
                onTap: _openUserProfile,
                child: Row(children: [
                  Text(widget.post.name, style: const TextStyle(
                    color: Colors.white, fontSize: 14,
                    fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                  if (widget.post.isFollowing) ...[
                    const SizedBox(width: 6),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6)),
                      child: const Text('Following', style: TextStyle(
                        color: _accent, fontSize: 10,
                        fontWeight: FontWeight.w600, fontFamily: 'Inter'))),
                  ],
                ]),
              ),
              Row(children: [
                Text(widget.post.username, style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12, fontFamily: 'Inter')),
                const SizedBox(width: 6),
                Text('· ${_timeAgo(widget.post.createdAt)}',
                  style: TextStyle(color: Colors.white.withOpacity(0.3),
                    fontSize: 12, fontFamily: 'Inter')),
              ]),
            ])),
            // More
            GestureDetector(onTap: _showMore,
              child: Padding(padding: const EdgeInsets.all(8),
                child: Icon(CupertinoIcons.ellipsis,
                  color: Colors.white.withOpacity(0.4), size: 18))),
          ]),
        ),

        // ── Title ────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
          child: Text(widget.post.title, style: const TextStyle(
            color: Colors.white, fontSize: 16,
            fontWeight: FontWeight.w800, height: 1.35, fontFamily: 'Inter'))),

        // ── Body ─────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(displayBody, style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 14, height: 1.55, fontFamily: 'Inter')),
            if (isLong)
              GestureDetector(
                onTap: () => setState(() => _showFullBody = !_showFullBody),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(_showFullBody ? 'Show less' : 'Read more',
                    style: const TextStyle(color: _accent, fontSize: 13,
                      fontWeight: FontWeight.w600, fontFamily: 'Inter')))),
          ])),

        // ── Media ────────────────────────────────────────────
        if (widget.post.hasMedia && widget.post.mediaUrls.isNotEmpty)
          _MediaSection(post: widget.post),

        const SizedBox(height: 12),

        // ── Stats ────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Row(children: [
            Icon(CupertinoIcons.eye, size: 13,
              color: Colors.white.withOpacity(0.3)),
            const SizedBox(width: 4),
            Text(_fmt(widget.post.views), style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12, fontFamily: 'Inter')),
          ])),

        // ── Divider ──────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Divider(color: Colors.white.withOpacity(0.06), height: 1)),

        // ── Actions ──────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ⬆️ Upvote
              _Action(
                icon: widget.post.isUpvoted
                    ? CupertinoIcons.arrow_up_circle_fill
                    : CupertinoIcons.arrow_up_circle,
                label: _fmt(widget.post.upvotes),
                color: widget.post.isUpvoted ? _accent : Colors.white54,
                animation: _likeScale,
                onTap: _toggleUpvote,
              ),
              // ✅ 💬 Comments → CommentsScreen
              _Action(
                icon: CupertinoIcons.chat_bubble,
                label: _fmt(widget.post.comments),
                color: Colors.white54,
                onTap: _openComments,
              ),
              // ✅ 📤 Share → ShareSheet
              _Action(
                icon: CupertinoIcons.arrowshape_turn_up_right,
                label: _fmt(widget.post.shares),
                color: Colors.white54,
                onTap: _openShare,
              ),
              // 🔖 Bookmark
              _Action(
                icon: widget.post.isBookmarked
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                label: '',
                color: widget.post.isBookmarked
                    ? Colors.yellowAccent
                    : Colors.white54,
                onTap: _toggleBookmark,
              ),
            ],
          )),
      ]),
    );
  }
}

// ── Action Button ─────────────────────────────────────────

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final Animation<double>? animation;

  const _Action({required this.icon, required this.label,
    required this.color, required this.onTap, this.animation});

  @override
  Widget build(BuildContext context) {
    Widget child = Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: color, size: 20),
      if (label.isNotEmpty) ...[
        const SizedBox(width: 5),
        Text(label, style: TextStyle(color: color, fontSize: 13,
          fontWeight: FontWeight.w600, fontFamily: 'Inter')),
      ],
    ]);

    if (animation != null) {
      child = AnimatedBuilder(animation: animation!,
        builder: (_, __) => Transform.scale(scale: animation!.value, child: child));
    }

    return GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque,
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: child));
  }
}

// ── Media Section ─────────────────────────────────────────

class _MediaSection extends StatefulWidget {
  final NewsPostModel post;
  const _MediaSection({required this.post});

  @override
  State<_MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<_MediaSection> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final urls = widget.post.mediaUrls;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(children: [
            PageView.builder(
              itemCount: urls.length,
              onPageChanged: (i) => setState(() => _idx = i),
              itemBuilder: (_, i) => Container(
                color: Colors.white.withOpacity(0.05),
                child: Center(child: Icon(
                  widget.post.mediaType == 'video'
                      ? CupertinoIcons.videocam
                      : widget.post.mediaType == 'audio'
                          ? CupertinoIcons.music_note_2
                          : CupertinoIcons.photo,
                  color: Colors.white24, size: 48)))),
            if (urls.length > 1)
              Positioned(bottom: 8, left: 0, right: 0,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(urls.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: _idx == i ? 16 : 6, height: 6,
                    decoration: BoxDecoration(
                      color: _idx == i ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(3)))))),
          ]),
        ),
      ),
    );
  }
}

