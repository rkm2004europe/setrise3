import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showUserPreviewSheet(
  BuildContext context, {
  required String userId,
  required String userName,
  required String username,
  String? avatarUrl,
  String bio = '',
  int followers = 0,
  int following = 0,
  int postsCount = 0,
  bool isVerified = false,
  bool isFollowing = false,
  Color accent = const Color(0xFF6C63FF),
  VoidCallback? onViewProfile,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _UserPreviewSheet(
      userId: userId,
      userName: userName,
      username: username,
      avatarUrl: avatarUrl,
      bio: bio,
      followers: followers,
      following: following,
      postsCount: postsCount,
      isVerified: isVerified,
      isFollowing: isFollowing,
      accent: accent,
      onViewProfile: onViewProfile,
    ),
  );
}

class _UserPreviewSheet extends StatefulWidget {
  final String userId, userName, username;
  final String? avatarUrl;
  final String bio;
  final int followers, following, postsCount;
  final bool isVerified, isFollowing;
  final Color accent;
  final VoidCallback? onViewProfile;

  const _UserPreviewSheet({
    required this.userId,
    required this.userName,
    required this.username,
    this.avatarUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.postsCount,
    required this.isVerified,
    required this.isFollowing,
    required this.accent,
    this.onViewProfile,
  });

  @override
  State<_UserPreviewSheet> createState() => _UserPreviewSheetState();
}

class _UserPreviewSheetState extends State<_UserPreviewSheet>
    with SingleTickerProviderStateMixin {
  late bool _isFollowing;
  late AnimationController _followAnim;
  late Animation<double> _followScale;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
    _followAnim = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300));
    _followScale = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
            parent: _followAnim, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _followAnim.dispose();
    super.dispose();
  }

  String _fmt(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(1)}M';
    }
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(1)}K';
    }
    return '$n';
  }

  void _toggleFollow() {
    HapticFeedback.selectionClick();
    _followAnim.forward().then((_) => _followAnim.reverse());
    setState(() => _isFollowing = !_isFollowing);
    if (!_isFollowing) {
      // optional unfollow confirmation
      // يمكن إظهار حوار هنا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
          20, 14, 20, 20 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2)),
          ),

          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            widget.accent.withOpacity(0.5),
                        width: 2),
                    color: Colors.white10),
                child: ClipOval(
                  child: widget.avatarUrl != null
                      ? Image.network(widget.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              _placeholder())
                      : _placeholder(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.userName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Inter'),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.isVerified) ...[
                          const SizedBox(width: 4),
                          Icon(Icons.verified_rounded,
                              color: widget.accent,
                              size: 16),
                        ],
                      ],
                    ),
                    Text(
                      widget.username,
                      style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontFamily: 'Inter'),
                    ),
                    if (widget.bio.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        widget.bio,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showMore(),
                icon: const Icon(Icons.more_horiz_rounded,
                    color: Colors.white54, size: 22),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                    minWidth: 36, minHeight: 36),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats
          Row(
            children: [
              _Stat(
                  label: 'Posts',
                  value: _fmt(widget.postsCount),
                  accent: widget.accent),
              Container(
                  width: 1,
                  height: 32,
                  color: Colors.white12,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4)),
              _Stat(
                  label: 'Followers',
                  value: _fmt(widget.followers),
                  accent: widget.accent),
              Container(
                  width: 1,
                  height: 32,
                  color: Colors.white12,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4)),
              _Stat(
                  label: 'Following',
                  value: _fmt(widget.following),
                  accent: widget.accent),
            ],
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _Btn(
                  label: _isFollowing ? 'Following' : 'Follow',
                  icon: _isFollowing
                      ? Icons.check_rounded
                      : Icons.person_add_rounded,
                  filled: !_isFollowing,
                  accent: widget.accent,
                  onTap: _toggleFollow,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: _Btn(
                  label: 'Message',
                  icon: Icons.chat_bubble_outline_rounded,
                  filled: false,
                  accent: widget.accent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: _Btn(
                  label: 'View Profile',
                  icon: Icons.person_outline_rounded,
                  filled: false,
                  accent: widget.accent,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onViewProfile?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMore() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.fromLTRB(
            0, 14, 0, 16 + MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2)),
            ),
            ListTile(
              leading: const Icon(Icons.visibility_off_rounded,
                  color: Colors.white70),
              title: const Text('Hide content',
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Inter')),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag_outlined,
                  color: Colors.orangeAccent),
              title: const Text('Report',
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontFamily: 'Inter')),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block_rounded,
                  color: Colors.redAccent),
              title: const Text('Block',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Inter')),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close_rounded,
                  color: Colors.white70),
              title: const Text('Cancel',
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Inter')),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => Center(
        child: Icon(Icons.person_rounded,
            color: widget.accent.withOpacity(0.6),
            size: 30),
      );
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color accent;
  const _Stat(
      {required this.label,
      required this.value,
      required this.accent});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Inter')),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    fontFamily: 'Inter')),
          ],
        ),
      );
}

class _Btn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final Color accent;
  final VoidCallback onTap;

  const _Btn({
    required this.label,
    required this.icon,
    required this.filled,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: filled ? accent : Colors.white10,
            borderRadius: BorderRadius.circular(14),
            border:
                filled ? null : Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: filled ? Colors.white : Colors.white70,
                  size: 15),
              const SizedBox(width: 5),
              Text(label,
                  style: TextStyle(
                      color:
                          filled ? Colors.white : Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter')),
            ],
          ),
        ),
      );
}
