// lib/features/comment/screens/comments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/comment/models/comment_model.dart';
import 'package:setrise/features/user/screens/widgets/user_preview_sheet.dart';

class CommentsScreen extends StatefulWidget {
  final String contextId;
  final String contextName;
  final CommentContextType contextType;
  final Color accent;

  const CommentsScreen({
    Key? key,
    required this.contextId,
    required this.contextName,
    required this.accent,
    this.contextType = CommentContextType.general,
  }) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _textCtrl  = TextEditingController();
  final _focusNode = FocusNode();
  String? _replyingToId;
  String? _replyingToName;
  late List<CommentModel> _comments;

  @override
  void initState() {
    super.initState();
    _comments = _mock();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<CommentModel> _mock() => [
    CommentModel(id: 'c1', userId: 'u1', userName: 'Ahmed K.', username: '@ahmed_k',
      bio: 'Flutter Developer 🚀', followers: 12400, following: 320, postsCount: 87,
      isVerified: true, text: 'هذا المنتج رائع جداً! 🔥',
      date: DateTime.now().subtract(const Duration(hours: 2)), likes: 24, reposts: 5,
      replies: [
        CommentModel(id: 'c1r1', userId: 'u2', userName: 'Sara M.', username: '@sara_m',
          text: 'أوافقك الرأي 👍', date: DateTime.now().subtract(const Duration(hours: 1)), likes: 8),
      ]),
    CommentModel(id: 'c2', userId: 'me', userName: 'You', username: '@you',
      text: 'سعر ممتاز! 💯', date: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 11, reposts: 2, isOwn: true),
    CommentModel(id: 'c3', userId: 'u4', userName: 'Omar T.', username: '@omar_t',
      bio: 'Content Creator', followers: 5200, postsCount: 43,
      text: 'محتوى رائع 🙌', date: DateTime.now().subtract(const Duration(days: 1)),
      likes: 33, reposts: 12),
  ];

  void _send() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    HapticFeedback.mediumImpact();
    final newC = CommentModel(id: '${DateTime.now().millisecondsSinceEpoch}',
      userId: 'me', userName: 'You', username: '@you', text: text, isOwn: true);
    setState(() {
      if (_replyingToId != null) {
        _addReply(_comments, _replyingToId!, newC);
      } else {
        _comments.insert(0, newC);
      }
      _textCtrl.clear();
      _replyingToId = null;
      _replyingToName = null;
    });
  }

  bool _addReply(List<CommentModel> list, String id, CommentModel r) {
    for (final c in list) {
      if (c.id == id) { c.replies.add(r); return true; }
      if (_addReply(c.replies, id, r)) return true;
    }
    return false;
  }

  void _onUserTap(CommentModel c) {
    if (c.isOwn) return;
    showUserPreviewSheet(context,
      userId: c.userId, userName: c.userName, username: c.username,
      avatarUrl: c.avatarUrl, bio: c.bio, followers: c.followers,
      following: c.following, postsCount: c.postsCount,
      isVerified: c.isVerified, isFollowing: c.isFollowing,
      accent: widget.accent);
  }

  String _ago(DateTime d) {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1C1C1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Comments • ${widget.contextName}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E), fontFamily: 'Inter')),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFF2F2F7))),
      ),
      body: Column(children: [
        Expanded(child: _comments.isEmpty
          ? Center(child: Icon(Icons.chat_bubble_outline_rounded,
              size: 56, color: widget.accent.withOpacity(0.25)))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _comments.length,
              itemBuilder: (_, i) {
                final c = _comments[i];
                if (c.isDeleted) return const _Deleted();
                return _Card(
                  comment: c, accent: widget.accent, ago: _ago(c.date),
                  isReply: false, onUserTap: () => _onUserTap(c),
                  onLike: () => setState(() { c.liked = !c.liked; c.likes += c.liked ? 1 : -1; }),
                  onReply: () => setState(() {
                    _replyingToId = c.id; _replyingToName = c.userName;
                    _focusNode.requestFocus();
                  }),
                  replies: c.replies,
                  buildReply: (r) => _Card(
                    comment: r, accent: widget.accent, ago: _ago(r.date),
                    isReply: true, onUserTap: () => _onUserTap(r),
                    onLike: () => setState(() { r.liked = !r.liked; r.likes += r.liked ? 1 : -1; }),
                    onReply: () => setState(() {
                      _replyingToId = c.id; _replyingToName = r.userName;
                      _focusNode.requestFocus();
                    }),
                    replies: const [], buildReply: (_) => const SizedBox(),
                  ),
                );
              }),
        ),
        _Input(ctrl: _textCtrl, focusNode: _focusNode, accent: widget.accent,
          replyingTo: _replyingToName,
          onSend: _send,
          onCancel: () => setState(() { _replyingToId = null; _replyingToName = null; })),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ]),
    );
  }
}

// ── Card ─────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final CommentModel comment;
  final Color accent;
  final String ago;
  final bool isReply;
  final VoidCallback onUserTap, onLike, onReply;
  final List<CommentModel> replies;
  final Widget Function(CommentModel) buildReply;

  const _Card({required this.comment, required this.accent, required this.ago,
    required this.isReply, required this.onUserTap, required this.onLike,
    required this.onReply, required this.replies, required this.buildReply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 42.0 : 0, bottom: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(onTap: onUserTap,
          child: CircleAvatar(radius: isReply ? 15 : 19,
            backgroundColor: accent.withOpacity(0.15),
            child: Text(comment.userName.isNotEmpty ? comment.userName[0].toUpperCase() : '?',
              style: TextStyle(color: accent, fontWeight: FontWeight.w800,
                fontSize: isReply ? 11 : 13, fontFamily: 'Inter')))),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            GestureDetector(onTap: onUserTap,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(comment.userName, style: const TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w700, color: Color(0xFF1C1C1E), fontFamily: 'Inter')),
                if (comment.isVerified) ...[const SizedBox(width: 3),
                  Icon(Icons.verified_rounded, color: accent, size: 12)],
                if (comment.isOwn) ...[const SizedBox(width: 4),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6)),
                    child: Text('You', style: TextStyle(fontSize: 9, color: accent,
                      fontWeight: FontWeight.w700, fontFamily: 'Inter')))],
              ])),
            const SizedBox(width: 6),
            Text(ago, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93), fontFamily: 'Inter')),
          ]),
          if (comment.text != null) ...[
            const SizedBox(height: 4),
            Text(comment.text!, style: const TextStyle(fontSize: 14,
              color: Color(0xFF3A3A3C), height: 1.5, fontFamily: 'Inter')),
          ],
          const SizedBox(height: 8),
          Row(children: [
            GestureDetector(onTap: onLike, child: Row(children: [
              Icon(comment.liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: 17, color: comment.liked ? Colors.red : const Color(0xFF8E8E93)),
              if (comment.likes > 0) ...[const SizedBox(width: 4),
                Text('${comment.likes}', style: const TextStyle(fontSize: 12,
                  color: Color(0xFF8E8E93), fontFamily: 'Inter'))],
            ])),
            const SizedBox(width: 18),
            GestureDetector(onTap: onReply,
              child: const Text('Reply', style: TextStyle(fontSize: 12,
                color: Color(0xFF8E8E93), fontFamily: 'Inter'))),
          ]),
          if (replies.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...replies.map((r) => r.isDeleted ? const _Deleted() : buildReply(r)),
          ],
        ])),
      ]),
    );
  }
}

// ── Input ────────────────────────────────────────────────────

class _Input extends StatelessWidget {
  final TextEditingController ctrl;
  final FocusNode focusNode;
  final Color accent;
  final String? replyingTo;
  final VoidCallback onSend, onCancel;

  const _Input({required this.ctrl, required this.focusNode, required this.accent,
    required this.replyingTo, required this.onSend, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF2F2F7)))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (replyingTo != null)
          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: accent.withOpacity(0.07),
            child: Row(children: [
              Icon(Icons.reply_rounded, size: 14, color: accent),
              const SizedBox(width: 6),
              Text('Replying to $replyingTo',
                style: TextStyle(fontSize: 12, color: accent, fontFamily: 'Inter')),
              const Spacer(),
              GestureDetector(onTap: onCancel,
                child: const Icon(Icons.close, size: 14, color: Color(0xFF8E8E93))),
            ])),
        Padding(padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(children: [
            Expanded(child: Container(
              constraints: const BoxConstraints(minHeight: 40),
              decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(controller: ctrl, focusNode: focusNode, maxLines: null,
                style: const TextStyle(fontSize: 14, color: Color(0xFF1C1C1E), fontFamily: 'Inter'),
                decoration: const InputDecoration(hintText: 'Add a comment...',
                  hintStyle: TextStyle(color: Color(0xFF8E8E93), fontFamily: 'Inter'),
                  border: InputBorder.none, isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10))),
            )),
            const SizedBox(width: 8),
            GestureDetector(onTap: onSend,
              child: Container(width: 36, height: 36,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 16))),
          ])),
      ]),
    );
  }
}

class _Deleted extends StatelessWidget {
  const _Deleted();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Text('Comment deleted.', style: TextStyle(fontSize: 12,
      color: Color(0xFFAEAEB2), fontStyle: FontStyle.italic, fontFamily: 'Inter')));
}
