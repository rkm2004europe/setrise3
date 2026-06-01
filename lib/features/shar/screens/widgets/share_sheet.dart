// lib/features/shar/screens/widgets/share_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SharePostData {
  final String postId;
  final String authorName;
  final String authorUsername;
  final String? authorAvatar;
  final String? content;
  final String? mediaUrl;
  final Color accentColor;

  const SharePostData({
    required this.postId, required this.authorName, required this.authorUsername,
    this.authorAvatar, this.content, this.mediaUrl,
    this.accentColor = const Color(0xFF6C63FF),
  });
}

void showShareSheet(BuildContext context, {required SharePostData post}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_) => _ShareSheet(post: post),
  );
}

class _ShareSheet extends StatefulWidget {
  final SharePostData post;
  const _ShareSheet({required this.post});
  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> with SingleTickerProviderStateMixin {
  final _noteCtrl = TextEditingController();
  bool _isSharing = false;
  bool _isSuccess = false;
  late AnimationController _anim;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scale = CurvedAnimation(parent: _anim, curve: Curves.elasticOut);
  }

  @override
  void dispose() { _noteCtrl.dispose(); _anim.dispose(); super.dispose(); }

  Future<void> _share() async {
    FocusScope.of(context).unfocus();
    HapticFeedback.mediumImpact();
    setState(() => _isSharing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() { _isSharing = false; _isSuccess = true; });
    _anim.forward();
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [
        Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
        SizedBox(width: 10), Text('Posted to your profile!',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
      ]),
      backgroundColor: const Color(0xFF1C1C1E), behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.all(16), duration: const Duration(seconds: 2),
    ));
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: 'https://setrise.app/post/${widget.post.postId}'));
    HapticFeedback.selectionClick();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Link copied!'), backgroundColor: Color(0xFF1C1C1E),
      duration: Duration(seconds: 1), behavior: SnackBarBehavior.floating));
  }

  Color get _accent => widget.post.accentColor;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.62, minChildSize: 0.45, maxChildSize: 0.92,
      snap: true, snapSizes: const [0.62, 0.92],
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(color: Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        child: Column(children: [
          // Handle
          Padding(padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
          // Header
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(children: [
              const Text('Share Post', style: TextStyle(color: Colors.white, fontSize: 18,
                fontWeight: FontWeight.w900, fontFamily: 'Inter')),
              const Spacer(),
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 30, height: 30,
                  decoration: const BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
                  child: const Icon(Icons.close_rounded, color: Colors.white60, size: 16))),
            ])),
          // Content
          Expanded(child: ListView(controller: ctrl,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20 + MediaQuery.of(context).padding.bottom),
            children: [
              // Note field
              Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(children: [
                  Container(width: 32, height: 32,
                    decoration: BoxDecoration(color: _accent.withOpacity(0.15), shape: BoxShape.circle),
                    child: Icon(Icons.edit_rounded, color: _accent, size: 15)),
                  const SizedBox(width: 12),
                  Expanded(child: TextField(controller: _noteCtrl, maxLines: null,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter'),
                    decoration: InputDecoration(hintText: 'Write something about this post...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14, fontFamily: 'Inter'),
                      border: InputBorder.none, isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12)))),
                ])),
              const SizedBox(height: 14),
              // Post preview
              Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
                padding: const EdgeInsets.all(14),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: 40, height: 40,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      color: _accent.withOpacity(0.2),
                      border: Border.all(color: _accent.withOpacity(0.4), width: 1.5)),
                    child: Center(child: Text(
                      widget.post.authorName.isNotEmpty ? widget.post.authorName[0].toUpperCase() : '?',
                      style: TextStyle(color: _accent, fontWeight: FontWeight.w900,
                        fontSize: 16, fontFamily: 'Inter')))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(widget.post.authorName, style: const TextStyle(color: Colors.white,
                        fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                      const SizedBox(width: 6),
                      Text(widget.post.authorUsername, style: const TextStyle(
                        color: Colors.white38, fontSize: 12, fontFamily: 'Inter')),
                    ]),
                    if (widget.post.content != null) ...[
                      const SizedBox(height: 6),
                      Text(widget.post.content!, maxLines: 3, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 13,
                          height: 1.5, fontFamily: 'Inter')),
                    ],
                  ])),
                ])),
              const SizedBox(height: 20),
              // Share to Profile button
              GestureDetector(
                onTap: (_isSharing || _isSuccess) ? null : _share,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity, height: 56,
                  decoration: BoxDecoration(
                    color: _isSuccess ? const Color(0xFF34C759) : _isSharing ? _accent.withOpacity(0.7) : _accent,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [BoxShadow(color: (_isSuccess ? const Color(0xFF34C759) : _accent).withOpacity(0.35),
                      blurRadius: 20, offset: const Offset(0, 8))]),
                  child: Center(child: _isSharing
                    ? const SizedBox(width: 22, height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : _isSuccess
                      ? ScaleTransition(scale: _scale, child: const Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 22),
                          SizedBox(width: 8),
                          Text('Shared!', style: TextStyle(color: Colors.white, fontSize: 16,
                            fontWeight: FontWeight.w800, fontFamily: 'Inter'))]))
                      : const Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.person_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('Share to Profile', style: TextStyle(color: Colors.white, fontSize: 16,
                            fontWeight: FontWeight.w800, fontFamily: 'Inter'))])),
                )),
              const SizedBox(height: 24),
              // Divider
              Row(children: [
                Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('or share via', style: TextStyle(color: Colors.white38, fontSize: 11, fontFamily: 'Inter'))),
                Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
              ]),
              const SizedBox(height: 20),
              // Quick share icons
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _AppIcon(icon: Icons.chat_rounded,      label: 'Chat',  color: const Color(0xFF34C759)),
                  _AppIcon(icon: Icons.camera_alt_rounded, label: 'Story', color: const Color(0xFFFF2D55)),
                  _AppIcon(icon: Icons.email_rounded,      label: 'Email', color: const Color(0xFF007AFF)),
                  _AppIcon(icon: Icons.link_rounded,       label: 'Link',  color: const Color(0xFFFF9500), onTap: _copyLink),
                  _AppIcon(icon: Icons.more_horiz_rounded, label: 'More',  color: const Color(0xFF8E8E93)),
                ]),
              const SizedBox(height: 20),
              // Options
              _Option(icon: Icons.send_rounded,     label: 'Send as Message', sub: 'Share directly to a friend', accent: _accent,
                onTap: () => Navigator.pop(context)),
              _Option(icon: Icons.link_rounded,     label: 'Copy Link',       sub: 'Copy post link to clipboard', accent: _accent,
                onTap: _copyLink),
              _Option(icon: Icons.ios_share_rounded, label: 'More Options',   sub: 'Share outside the app', accent: _accent,
                onTap: () => Navigator.pop(context)),
            ])),
        ]),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _AppIcon({required this.icon, required this.label, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () { HapticFeedback.selectionClick(); onTap?.call(); },
    child: Column(children: [
      Container(width: 54, height: 54,
        decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25))),
        child: Icon(icon, color: color, size: 24)),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11,
        fontFamily: 'Inter', fontWeight: FontWeight.w500)),
    ]));
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label, sub;
  final Color accent;
  final VoidCallback onTap;
  const _Option({required this.icon, required this.label, required this.sub,
    required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08))),
      child: Row(children: [
        Container(width: 40, height: 40,
          decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: accent, size: 20)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14,
            fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12, fontFamily: 'Inter')),
        ])),
        const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
      ])));
}
