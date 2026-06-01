// lib/features/setrize/screens/widgets/post_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/setrize/models/post_model.dart';
import 'package:setrise/features/comment/screens/comments_screen.dart';
import 'package:setrise/features/comment/models/comment_model.dart';
import 'package:setrise/features/shar/screens/widgets/share_sheet.dart';
import 'package:setrise/features/user/screens/widgets/user_preview_sheet.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final ValueChanged<PostModel> onUpdate;
  final VoidCallback onSwipeNext;
  final VoidCallback? onSwipeRight, onSwipeLeft, onSwipeStart, onSwipeEnd;

  const PostCard({
    super.key, required this.post, required this.onUpdate,
    required this.onSwipeNext, this.onSwipeRight, this.onSwipeLeft,
    this.onSwipeStart, this.onSwipeEnd,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  late AnimationController _heartCtrl;
  late Animation<double> _heartAnim;
  bool _showHeart = false;
  double _dragX = 0.0;
  bool _isDismissing = false;

  Color get _accent {
    final hsl = HSLColor.fromColor(widget.post.backgroundColor);
    return hsl.withSaturation(1.0).withLightness(0.62).toColor();
  }

  @override
  void initState() {
    super.initState();
    _heartCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _heartAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _heartCtrl, curve: Curves.elasticOut));
    _heartCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 350), () {
          if (!mounted) return;
          setState(() => _showHeart = false);
          _heartCtrl.reset();
        });
      }
    });
  }

  @override
  void dispose() { _heartCtrl.dispose(); super.dispose(); }

  void _onDragStart(DragStartDetails d) { widget.onSwipeStart?.call(); }

  void _onDragUpdate(DragUpdateDetails d) {
    if (_isDismissing) return;
    final w = MediaQuery.of(context).size.width;
    setState(() => _dragX = (_dragX + d.delta.dx).clamp(-w * 1.15, w * 1.15).toDouble());
  }

  void _onDragEnd(DragEndDetails d) {
    if (_isDismissing) return;
    final w = MediaQuery.of(context).size.width;
    final v = d.primaryVelocity ?? 0;
    if (_dragX.abs() > w * 0.22 || v.abs() > 850) {
      final right = _dragX >= 0 || v > 0;
      setState(() { _dragX = right ? w * 1.2 : -w * 1.2; _isDismissing = true; });
      HapticFeedback.mediumImpact();
      right ? widget.onSwipeRight?.call() : widget.onSwipeLeft?.call();
      Future.delayed(const Duration(milliseconds: 170), () {
        if (!mounted) return;
        widget.onSwipeNext();
        setState(() { _dragX = 0; _isDismissing = false; });
        widget.onSwipeEnd?.call();
      });
    } else {
      HapticFeedback.selectionClick();
      setState(() => _dragX = 0);
      widget.onSwipeEnd?.call();
    }
  }

  void _doubleTap() {
    setState(() => _showHeart = true);
    _heartCtrl.forward(from: 0);
    if (!widget.post.isLiked) _toggleLike();
  }

  void _toggleLike() => widget.onUpdate(widget.post.copyWith(
    isLiked: !widget.post.isLiked,
    likesCount: widget.post.isLiked ? widget.post.likesCount - 1 : widget.post.likesCount + 1));

  void _toggleSave() {
    HapticFeedback.selectionClick();
    widget.onUpdate(widget.post.copyWith(
      isSaved: !widget.post.isSaved,
      savesCount: widget.post.isSaved ? widget.post.savesCount - 1 : widget.post.savesCount + 1));
  }

  void _toggleFollow() {
    HapticFeedback.selectionClick();
    widget.onUpdate(widget.post.copyWith(isFollowing: !widget.post.isFollowing));
  }

  // ✅ Comments
  void _openComments() {
    HapticFeedback.selectionClick();
    showModalBottomSheet(context: context, isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(height: MediaQuery.of(context).size.height * 0.9,
        child: CommentsScreen(contextId: widget.post.id,
          contextName: widget.post.username,
          contextType: CommentContextType.post,
          accent: _accent)));
  }

  // ✅ Share
  void _openShare() {
    HapticFeedback.selectionClick();
    showShareSheet(context, post: SharePostData(
      postId: widget.post.id,
      authorName: widget.post.displayName.isNotEmpty ? widget.post.displayName : widget.post.username,
      authorUsername: widget.post.username,
      authorAvatar: widget.post.userAvatar,
      content: widget.post.title,
      mediaUrl: widget.post.mediaUrl,
      accentColor: _accent));
    widget.onUpdate(widget.post.copyWith(
      isShared: true, sharesCount: widget.post.sharesCount + 1));
  }

  // ✅ User Profile
  void _openUser() {
    showUserPreviewSheet(context,
      userId: widget.post.userId,
      userName: widget.post.displayName.isNotEmpty ? widget.post.displayName : widget.post.username,
      username: widget.post.username,
      avatarUrl: widget.post.userAvatar,
      isFollowing: widget.post.isFollowing,
      accent: _accent,
      onViewProfile: () { /* TODO: navigate to profile */ });
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final safe = MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () => widget.onUpdate(widget.post.copyWith(isPlaying: !widget.post.isPlaying)),
      onDoubleTap: _doubleTap,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onHorizontalDragCancel: () { setState(() => _dragX = 0); widget.onSwipeEnd?.call(); },
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Transform.rotate(
          angle: ((_dragX / (w == 0 ? 1 : w)) * 0.08).clamp(-0.08, 0.08).toDouble(),
          child: Stack(fit: StackFit.expand, children: [

            // Background
            _Bg(base: widget.post.backgroundColor, accent: _accent),

            // Pause icon
            if (!widget.post.isPlaying)
              Center(child: Container(width: 72, height: 72,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.45),
                  border: Border.all(color: _accent, width: 2)),
                child: Icon(Icons.play_arrow_rounded, color: _accent, size: 42))),

            // Bottom gradient
            Positioned(bottom: 0, left: 0, right: 0, height: 380,
              child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.88)])))),

            // ✅ Author — قابل للضغط
            Positioned(left: 16, right: 80, bottom: safe + 90,
              child: GestureDetector(onTap: _openUser,
                child: Row(children: [
                  Container(width: 42, height: 42,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(color: _accent, width: 2), color: Colors.white12),
                    child: ClipOval(child: widget.post.userAvatar != null
                      ? Image.network(widget.post.userAvatar!, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _avFallback())
                      : _avFallback())),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Flexible(child: Text(
                        widget.post.displayName.isNotEmpty ? widget.post.displayName : widget.post.username,
                        style: const TextStyle(color: Colors.white, fontSize: 15,
                          fontWeight: FontWeight.w800, fontFamily: 'Inter'),
                        overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 8),
                      GestureDetector(onTap: _toggleFollow,
                        child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.post.isFollowing ? Colors.transparent : _accent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: widget.post.isFollowing ? Colors.white54 : _accent)),
                          child: Text(widget.post.isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(color: widget.post.isFollowing ? Colors.white70 : Colors.white,
                              fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Inter')))),
                    ]),
                    Text(widget.post.username, style: const TextStyle(
                      color: Colors.white60, fontSize: 12, fontFamily: 'Inter')),
                  ])),
                ]))),

            // Title
            Positioned(left: 16, right: 80, bottom: safe + 48,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.post.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 15,
                    fontWeight: FontWeight.w600, height: 1.4, fontFamily: 'Inter')),
                if (widget.post.hashtags != null) ...[
                  const SizedBox(height: 4),
                  Text(widget.post.hashtags!,
                    style: TextStyle(color: _accent, fontSize: 13, fontFamily: 'Inter')),
                ],
              ])),

            // ✅ Sidebar actions
            Positioned(right: 12, bottom: safe + 40,
              child: Column(children: [
                _Side(icon: widget.post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  label: _fmt(widget.post.likesCount),
                  color: widget.post.isLiked ? Colors.red : Colors.white,
                  glow: widget.post.isLiked ? Colors.red : Colors.transparent,
                  onTap: _toggleLike),
                const SizedBox(height: 20),
                _Side(icon: Icons.chat_bubble_rounded, label: _fmt(widget.post.commentsCount),
                  color: Colors.white, onTap: _openComments),
                const SizedBox(height: 20),
                _Side(icon: Icons.reply_rounded, label: _fmt(widget.post.sharesCount),
                  color: widget.post.isShared ? _accent : Colors.white,
                  glow: widget.post.isShared ? _accent : Colors.transparent,
                  onTap: _openShare),
                const SizedBox(height: 20),
                _Side(icon: widget.post.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  label: _fmt(widget.post.savesCount),
                  color: widget.post.isSaved ? Colors.yellowAccent : Colors.white,
                  glow: widget.post.isSaved ? Colors.yellowAccent : Colors.transparent,
                  onTap: _toggleSave),
                const SizedBox(height: 20),
                _Side(icon: Icons.visibility_rounded, label: _fmt(widget.post.viewsCount),
                  color: Colors.white54, onTap: () {}),
              ])),

            // Double tap heart
            if (_showHeart)
              Center(child: ScaleTransition(scale: _heartAnim,
                child: const Icon(Icons.favorite_rounded, color: Colors.red, size: 100))),

            // Swipe labels
            if (_dragX > 44)
              Positioned(top: 60, left: 20, child: _Label(text: '⭐ Interested', color: Colors.greenAccent)),
            if (_dragX < -44)
              Positioned(top: 60, right: 20, child: _Label(text: 'Skip ✕', color: Colors.redAccent)),
          ]),
        ),
      ),
    );
  }

  Widget _avFallback() => Center(child: Text(
    widget.post.username.length > 1 ? widget.post.username[1].toUpperCase() : '?',
    style: TextStyle(color: _accent, fontWeight: FontWeight.w900, fontSize: 16)));
}

class _Side extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color glow;
  final VoidCallback onTap;
  const _Side({required this.icon, required this.label, required this.color,
    required this.onTap, this.glow = Colors.transparent});

  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Column(children: [
      Container(width: 50, height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
          boxShadow: glow != Colors.transparent
            ? [BoxShadow(color: glow.withOpacity(0.4), blurRadius: 16)] : null),
        child: Icon(icon, color: color, size: 26)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 12,
        fontWeight: FontWeight.w700, fontFamily: 'Inter')),
    ]));
}

class _Label extends StatelessWidget {
  final String text;
  final Color color;
  const _Label({required this.text, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.6), width: 2)),
    child: Text(text, style: TextStyle(color: color, fontSize: 15,
      fontWeight: FontWeight.w900, fontFamily: 'Inter')));
}

class _Bg extends StatelessWidget {
  final Color base, accent;
  const _Bg({required this.base, required this.accent});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(gradient: RadialGradient(
      center: const Alignment(-0.3, -0.4), radius: 1.2,
      colors: [accent.withOpacity(0.25), base])));
}
