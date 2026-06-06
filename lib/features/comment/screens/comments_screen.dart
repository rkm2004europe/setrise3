import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/comment_models.dart';
import '../data/mock_comments.dart';

// ═══════════════════════════════════════════════════════════════
// COMMENTS SCREEN
// ═══════════════════════════════════════════════════════════════
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

class _CommentsScreenState extends State<CommentsScreen>
    with TickerProviderStateMixin {
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _focusNode = FocusNode();
  bool _isRecording = false;
  String? _replyingToId;
  String? _replyingToName;
  final List<CommentMedia> _pendingMedia = [];
  late List<CommentVM> _comments;
  late AnimationController _sendAnim;

  @override
  void initState() {
    super.initState();
    _sendAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _comments = generateMockComments();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    _sendAnim.dispose();
    super.dispose();
  }

  // ── إرسال ──────────────────────────────────────────────────
  void _send() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty && _pendingMedia.isEmpty) return;

    HapticFeedback.mediumImpact();
    _sendAnim.forward().then((_) => _sendAnim.reverse());

    final newComment = CommentVM(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      userId: 'me',
      userName: 'You',
      text: text.isNotEmpty ? text : null,
      media: List.from(_pendingMedia),
      isOwn: true,
    );

    setState(() {
      if (_replyingToId != null) {
        _addReply(_comments, _replyingToId!, newComment);
      } else {
        _comments.insert(0, newComment);
      }
      _textCtrl.clear();
      _pendingMedia.clear();
      _replyingToId = null;
      _replyingToName = null;
    });
  }

  bool _addReply(List<CommentVM> list, String id, CommentVM reply) {
    for (final c in list) {
      if (c.id == id) { c.replies.add(reply); return true; }
      if (_addReply(c.replies, id, reply)) return true;
    }
    return false;
  }

  void _deleteComment(String id) {
    bool _del(List<CommentVM> list) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].id == id) { setState(() => list[i].isDeleted = true); return true; }
        if (_del(list[i].replies)) return true;
      }
      return false;
    }
    _del(_comments);
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

  String get _title {
    switch (widget.contextType) {
      case CommentContextType.product: return 'Comments';
      case CommentContextType.live:    return 'Live Chat';
      case CommentContextType.post:    return 'Post Comments';
      case CommentContextType.reel:    return 'Reel Comments';
      default:                         return 'Comments';
    }
  }

  int get _totalComments {
    int count = _comments.where((c) => !c.isDeleted).length;
    for (final c in _comments) {
      count += c.replies.where((r) => !r.isDeleted).length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommentColors.background,
      body: Column(
        children: [
          // ═══ Top Bar (بدون AppBar) ═══
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: CommentColors.divider, width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Close
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: CommentColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 18, color: CommentColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: CommentColors.textPrimary)),
                        Text('$_totalComments comments • ${widget.contextName}',
                            style: const TextStyle(
                                fontSize: 11,
                                color: CommentColors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ═══ المحتوى الرئيسي ═══
          Expanded(
            child: _totalComments == 0
                ? _EmptyState(accent: widget.accent)
                : ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: _comments.length,
                    itemBuilder: (_, i) {
                      final c = _comments[i];
                      if (c.isDeleted) return const _DeletedCard();
                      return _CommentCard(
                        comment: c,
                        accent: widget.accent,
                        timeAgo: _timeAgo(c.date),
                        isReply: false,
                        onLike: () => setState(() {
                          c.liked = !c.liked;
                          c.likes += c.liked ? 1 : -1;
                        }),
                        onRepost: () => setState(() {
                          c.reposted = !c.reposted;
                          c.reposts += c.reposted ? 1 : -1;
                          if (c.reposted) HapticFeedback.mediumImpact();
                        }),
                        onReply: () => setState(() {
                          _replyingToId = c.id;
                          _replyingToName = c.userName;
                          _focusNode.requestFocus();
                        }),
                        onDelete: () => _deleteComment(c.id),
                        onShare: () => _showShareSheet(c),
                        onReport: () => _showReportSheet(c),
                        onMore: () => _showMoreSheet(c),
                        replies: c.replies,
                        buildReply: (r) => _CommentCard(
                          comment: r,
                          accent: widget.accent,
                          timeAgo: _timeAgo(r.date),
                          isReply: true,
                          onLike: () => setState(() {
                            r.liked = !r.liked;
                            r.likes += r.liked ? 1 : -1;
                          }),
                          onRepost: () => setState(() {
                            r.reposted = !r.reposted;
                            r.reposts += r.reposted ? 1 : -1;
                          }),
                          onReply: () => setState(() {
                            _replyingToId = c.id;
                            _replyingToName = r.userName;
                            _focusNode.requestFocus();
                          }),
                          onDelete: () => _deleteComment(r.id),
                          onShare: () => _showShareSheet(r),
                          onReport: () => _showReportSheet(r),
                          onMore: () => _showMoreSheet(r),
                          replies: const [],
                          buildReply: (_) => const SizedBox(),
                        ),
                      );
                    },
                  ),
          ),

          // ═══ شريط الإدخال ═══
          _InputBar(
            ctrl: _textCtrl,
            focusNode: _focusNode,
            accent: widget.accent,
            isRecording: _isRecording,
            replyingToName: _replyingToName,
            pendingMedia: _pendingMedia,
            onSend: _send,
            onRecord: () {
              HapticFeedback.heavyImpact();
              setState(() {
                _isRecording = !_isRecording;
                if (_isRecording) {
                  _pendingMedia.add(CommentMedia(
                    type: _MediaType.audio,
                    path: 'voice_${DateTime.now().millisecondsSinceEpoch}.aac',
                    audioDuration: const Duration(seconds: 10),
                  ));
                }
              });
            },
            onAddImage: () => setState(() => _pendingMedia.add(
                const CommentMedia(type: _MediaType.image, path: 'img.jpg'))),
            onAddVideo: () => setState(() => _pendingMedia.add(
                const CommentMedia(type: _MediaType.video, path: 'vid.mp4'))),
            onRemoveMedia: (i) => setState(() => _pendingMedia.removeAt(i)),
            onCancelReply: () => setState(() {
              _replyingToId = null;
              _replyingToName = null;
            }),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  // ── Bottom Sheets ────────────────────────────────────────
  void _showMoreSheet(CommentVM c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CommentColors.bottomSheet,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _MoreSheet(
        isOwn: c.isOwn,
        onDelete: c.isOwn ? () {
          Navigator.pop(context);
          _deleteComment(c.id);
        } : null,
        onReport: !c.isOwn ? () {
          Navigator.pop(context);
          _showReportSheet(c);
        } : null,
        onCopy: () {
          Navigator.pop(context);
          if (c.text != null) {
            Clipboard.setData(ClipboardData(text: c.text!));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Copied!'), duration: Duration(seconds: 1)),
            );
          }
        },
      ),
    );
  }

  void _showShareSheet(CommentVM c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CommentColors.bottomSheet,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ShareSheet(accent: widget.accent, comment: c),
    );
  }

  void _showReportSheet(CommentVM c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CommentColors.bottomSheet,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ReportSheet(
        onReport: (reason) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reported: $reason'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// COMMENT CARD
// ═══════════════════════════════════════════════════════════════
class _CommentCard extends StatelessWidget {
  final CommentVM comment;
  final Color accent;
  final String timeAgo;
  final bool isReply;
  final VoidCallback onLike, onRepost, onReply, onDelete, onShare, onReport, onMore;
  final List<CommentVM> replies;
  final Widget Function(CommentVM) buildReply;

  const _CommentCard({
    required this.comment,
    required this.accent,
    required this.timeAgo,
    required this.isReply,
    required this.onLike,
    required this.onRepost,
    required this.onReply,
    required this.onDelete,
    required this.onShare,
    required this.onReport,
    required this.onMore,
    required this.replies,
    required this.buildReply,
  });

  @override
  Widget build(BuildContext context) {
    if (comment.isDeleted) return const _DeletedCard();

    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? 42.0 : 0,
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thread line + Avatar
          Column(
            children: [
              CircleAvatar(
                radius: isReply ? 15 : 19,
                backgroundColor: accent.withOpacity(0.15),
                child: Text(
                  comment.userName.isNotEmpty
                      ? comment.userName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w800,
                      fontSize: isReply ? 11 : 13),
                ),
              ),
              if (replies.isNotEmpty && !isReply)
                Container(
                  width: 2,
                  height: 40,
                  margin: const EdgeInsets.only(top: 4),
                  color: CommentColors.divider,
                ),
            ],
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Text(comment.userName,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: CommentColors.textPrimary)),
                    if (comment.isOwn) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('You',
                            style: TextStyle(
                                fontSize: 9,
                                color: accent,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                    const SizedBox(width: 6),
                    Text(timeAgo,
                        style: const TextStyle(
                            fontSize: 11,
                            color: CommentColors.textSecondary)),
                    const Spacer(),
                    GestureDetector(
                      onTap: onMore,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.more_horiz,
                            size: 18, color: CommentColors.textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Text
                if (comment.text != null)
                  Text(comment.text!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: CommentColors.textPrimary,
                          height: 1.5)),

                // Media
                if (comment.media.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _MediaPreview(media: comment.media, accent: accent),
                ],

                const SizedBox(height: 10),

                // Actions
                Row(
                  children: [
                    _ActionBtn(
                      icon: comment.liked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      label: _fmt(comment.likes + (comment.liked ? 0 : 0)),
                      color: comment.liked ? CommentColors.likeActive : CommentColors.textSecondary,
                      onTap: onLike,
                    ),
                    const SizedBox(width: 18),
                    _ActionBtn(
                      icon: comment.reposted
                          ? Icons.repeat_one_rounded
                          : Icons.repeat_rounded,
                      label: _fmt(comment.reposts),
                      color: comment.reposted ? accent : CommentColors.textSecondary,
                      onTap: onRepost,
                    ),
                    const SizedBox(width: 18),
                    _ActionBtn(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: isReply ? 'Reply' : _fmt(replies.length),
                      color: CommentColors.textSecondary,
                      onTap: onReply,
                    ),
                    const SizedBox(width: 18),
                    _ActionBtn(
                      icon: Icons.ios_share_rounded,
                      label: 'Share',
                      color: CommentColors.textSecondary,
                      onTap: onShare,
                    ),
                  ],
                ),

                // Replies
                if (replies.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...replies.map((r) => r.isDeleted
                      ? const _DeletedCard()
                      : buildReply(r)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) {
    if (n == 0) return '';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

// ═══════════════════════════════════════════════════════════════
// مكونات ثانوية
// ═══════════════════════════════════════════════════════════════

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 3),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}

class _MediaPreview extends StatelessWidget {
  final List<CommentMedia> media;
  final Color accent;
  const _MediaPreview({required this.media, required this.accent});

  @override
  Widget build(BuildContext context) {
    final images = media.where((m) => m.type == _MediaType.image).toList();
    final videos = media.where((m) => m.type == _MediaType.video).toList();
    final audios = media.where((m) => m.type == _MediaType.audio).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isNotEmpty)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: images.length == 1 ? 1 : 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: images.length == 1 ? 16 / 9 : 1,
            children: images
                .take(4)
                .map((img) => Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CommentColors.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(Icons.image_rounded,
                                size: 32, color: CommentColors.textSecondary),
                          ),
                        ),
                        if (images.length > 4 &&
                            images.indexOf(img) == 3)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '+${images.length - 4}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                      ],
                    ))
                .toList(),
          ),
        if (videos.isNotEmpty)
          ...videos.map((v) => Container(
                margin: const EdgeInsets.only(top: 6),
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.play_circle_fill_rounded,
                        size: 52, color: Colors.white),
                    Positioned(
                      bottom: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('0:45',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              )),
        if (audios.isNotEmpty)
          ...audios.map((a) => Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow_rounded,
                        color: accent, size: 22),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(
                        20,
                        (i) => Container(
                          width: 3,
                          height: (4 + (i % 5) * 4).toDouble(),
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      a.audioDuration != null
                          ? '${a.audioDuration!.inSeconds}s'
                          : '0:00',
                      style: TextStyle(
                          fontSize: 11,
                          color: accent),
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController ctrl;
  final FocusNode focusNode;
  final Color accent;
  final bool isRecording;
  final String? replyingToName;
  final List<CommentMedia> pendingMedia;
  final VoidCallback onSend, onRecord, onAddImage, onAddVideo, onCancelReply;
  final ValueChanged<int> onRemoveMedia;

  const _InputBar({
    required this.ctrl,
    required this.focusNode,
    required this.accent,
    required this.isRecording,
    required this.replyingToName,
    required this.pendingMedia,
    required this.onSend,
    required this.onRecord,
    required this.onAddImage,
    required this.onAddVideo,
    required this.onCancelReply,
    required this.onRemoveMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CommentColors.surface,
        border: Border(top: BorderSide(color: CommentColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (replyingToName != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              color: accent.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(Icons.reply_rounded, size: 14, color: accent),
                  const SizedBox(width: 6),
                  Text('Replying to $replyingToName',
                      style: TextStyle(fontSize: 12, color: accent, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: onCancelReply,
                    child: const Icon(Icons.close, size: 14, color: CommentColors.textSecondary),
                  ),
                ],
              ),
            ),
          if (pendingMedia.isNotEmpty)
            SizedBox(
              height: 76,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: pendingMedia.length,
                itemBuilder: (_, i) {
                  final m = pendingMedia[i];
                  return Stack(
                    children: [
                      Container(
                        width: 60, height: 60,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: m.type == _MediaType.audio
                              ? accent.withOpacity(0.1)
                              : CommentColors.inputBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: accent.withOpacity(0.2)),
                        ),
                        child: Icon(
                          m.type == _MediaType.image
                              ? Icons.image_rounded
                              : m.type == _MediaType.video
                                  ? Icons.videocam_rounded
                                  : Icons.mic_rounded,
                          color: m.type == _MediaType.audio ? accent : CommentColors.textSecondary,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 0, right: 4,
                        child: GestureDetector(
                          onTap: () => onRemoveMedia(i),
                          child: Container(
                            width: 18, height: 18,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            child: const Icon(Icons.close, size: 11, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          if (isRecording)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              color: Colors.red.withOpacity(0.05),
              child: Row(
                children: [
                  Container(width: 8, height: 8,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  const Text('Recording voice message...',
                      style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  const Text('Tap ■ to stop',
                      style: TextStyle(fontSize: 11, color: CommentColors.textSecondary)),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Btn(icon: Icons.image_outlined, color: CommentColors.textSecondary, onTap: onAddImage),
                const SizedBox(width: 4),
                _Btn(icon: Icons.videocam_outlined, color: CommentColors.textSecondary, onTap: onAddVideo),
                const SizedBox(width: 4),
                _Btn(
                  icon: isRecording ? Icons.stop_circle_outlined : Icons.mic_none_rounded,
                  color: isRecording ? Colors.red : CommentColors.textSecondary,
                  onTap: onRecord,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 120),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: CommentColors.inputBackground,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TextField(
                      controller: ctrl,
                      focusNode: focusNode,
                      style: const TextStyle(fontSize: 14, color: CommentColors.textPrimary),
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: isRecording
                            ? 'Add a caption...'
                            : replyingToName != null
                                ? 'Reply to $replyingToName...'
                                : 'Add a comment...',
                        hintStyle: const TextStyle(fontSize: 14, color: CommentColors.textHint),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onSend,
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                    child: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _Btn({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36, height: 36,
          decoration: const BoxDecoration(
              color: CommentColors.inputBackground, shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: color),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════
// Bottom Sheets
// ═══════════════════════════════════════════════════════════════

class _MoreSheet extends StatelessWidget {
  final bool isOwn;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final VoidCallback onCopy;

  const _MoreSheet({
    required this.isOwn,
    this.onDelete,
    this.onReport,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: CommentColors.textSecondary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)),
            ),
            _SheetTile(icon: Icons.copy_rounded, label: 'Copy Text', onTap: onCopy),
            if (isOwn && onDelete != null)
              _SheetTile(icon: Icons.delete_outline_rounded, label: 'Delete Comment',
                  color: CommentColors.deleteRed, onTap: onDelete!),
            if (!isOwn && onReport != null)
              _SheetTile(icon: Icons.flag_outlined, label: 'Report Comment',
                  color: CommentColors.deleteRed, onTap: onReport!),
            _SheetTile(icon: Icons.block_rounded, label: 'Block User',
                color: CommentColors.deleteRed, onTap: () => Navigator.pop(context)),
            _SheetTile(icon: Icons.close, label: 'Cancel',
                onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}

class _ShareSheet extends StatelessWidget {
  final Color accent;
  final CommentVM comment;
  const _ShareSheet({required this.accent, required this.comment});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'icon': Icons.repeat_rounded, 'label': 'Repost'},
      {'icon': Icons.link_rounded, 'label': 'Copy Link'},
      {'icon': Icons.send_rounded, 'label': 'Send via Chat'},
      {'icon': Icons.ios_share_rounded, 'label': 'Share to...'},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: CommentColors.textSecondary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Share Comment',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: CommentColors.textPrimary)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options
                  .map((o) => GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Column(
                          children: [
                            Container(
                              width: 56, height: 56,
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(o['icon'] as IconData,
                                  color: accent, size: 24),
                            ),
                            const SizedBox(height: 6),
                            Text(o['label'] as String,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: CommentColors.textSecondary)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportSheet extends StatelessWidget {
  final ValueChanged<String> onReport;
  const _ReportSheet({required this.onReport});

  @override
  Widget build(BuildContext context) {
    final reasons = [
      'Spam', 'Harassment or bullying', 'Hate speech',
      'False information', 'Inappropriate content', 'Other',
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: CommentColors.textSecondary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Report Comment',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: CommentColors.deleteRed)),
              ),
            ),
            ...reasons.map((r) => _SheetTile(
                  icon: Icons.flag_outlined,
                  label: r,
                  color: CommentColors.textPrimary,
                  onTap: () => onReport(r),
                )),
          ],
        ),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SheetTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = CommentColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(label,
          style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500)),
      onTap: onTap,
      dense: true,
    );
  }
}

class _DeletedCard extends StatelessWidget {
  const _DeletedCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: const [
          Icon(Icons.remove_circle_outline, size: 14, color: CommentColors.textSecondary),
          SizedBox(width: 6),
          Text('Comment deleted.',
              style: TextStyle(
                  fontSize: 12,
                  color: CommentColors.textSecondary,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Color accent;
  const _EmptyState({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline_rounded,
              size: 56, color: accent.withOpacity(0.25)),
          const SizedBox(height: 12),
          const Text('No comments yet',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: CommentColors.textSecondary)),
          const SizedBox(height: 4),
          const Text('Be the first to comment!',
              style: TextStyle(
                  fontSize: 13,
                  color: CommentColors.textHint)),
        ],
      ),
    );
  }
}
