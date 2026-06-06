import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/share_data.dart';

/// أقوى Share Sheet موحّدة في SetRise2
class ShareSheet {
  /// استدعاء سريع من أي مكان
  static void show(BuildContext context, {required ShareData data}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) => _ShareSheetWidget(data: data),
    );
  }
}

class _ShareSheetWidget extends StatefulWidget {
  final ShareData data;
  const _ShareSheetWidget({required this.data});

  @override
  State<_ShareSheetWidget> createState() => _ShareSheetWidgetState();
}

class _ShareSheetWidgetState extends State<_ShareSheetWidget>
    with SingleTickerProviderStateMixin {
  final _noteCtrl = TextEditingController();
  bool _isSharing = false;
  bool _isSuccess = false;
  String? _selectedQuickUserId;
  late AnimationController _anim;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scale = CurvedAnimation(parent: _anim, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    _anim.dispose();
    super.dispose();
  }

  Color get _accent => widget.data.accentColor;

  // ─── عمليات المشاركة الأساسية ────────────────────────
  Future<void> _shareToProfile() async {
    if (widget.data.onShareToProfile != null) {
      widget.data.onShareToProfile!();
      Navigator.pop(context);
      return;
    }
    await _simulateShare('Posted to profile!');
  }

  Future<void> _shareToStory() async {
    if (widget.data.onShareToStory != null) {
      widget.data.onShareToStory!();
      Navigator.pop(context);
      return;
    }
    await _simulateShare('Added to your story!');
  }

  Future<void> _shareToQuickUser(QuickShareUser user) async {
    setState(() => _selectedQuickUserId = user.id);
    await _simulateShare('Sent to ${user.name} ✉️');
    setState(() => _selectedQuickUserId = null);
  }

  Future<void> _simulateShare(String successMsg) async {
    FocusScope.of(context).unfocus();
    HapticFeedback.mediumImpact();
    setState(() => _isSharing = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _isSharing = false;
      _isSuccess = true;
    });
    _anim.forward();
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    Navigator.pop(context);
    _showSnack(successMsg);
  }

  void _copyLink() {
    final link = widget.data.link ?? 'https://setrise.app/item/${widget.data.id}';
    Clipboard.setData(ClipboardData(text: link));
    HapticFeedback.selectionClick();
    if (widget.data.onCopyLink != null) {
      widget.data.onCopyLink!();
    }
    Navigator.pop(context);
    _showSnack('Link copied!');
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(msg,
            style: const TextStyle(fontWeight: FontWeight.w600))),
      ]),
      backgroundColor: SharColors.surface,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ));
  }

  // ─── واجهة المستخدم ───────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.65, 0.95],
      builder: (_, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: SharColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(children: [
            // مقبض السحب
            _Handle(),
            // العنوان
            _Header(onClose: () => Navigator.pop(context)),
            // المحتوى القابل للتمرير
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.fromLTRB(
                    20, 8, 20, 20 + MediaQuery.of(context).padding.bottom),
                children: [
                  // حقل الملاحظة
                  _NoteField(noteCtrl: _noteCtrl, accent: _accent),
                  const SizedBox(height: 16),
                  // معاينة المحتوى
                  _PreviewCard(data: widget.data, accent: _accent),
                  const SizedBox(height: 20),
                  // أزرار المشاركة السريعة
                  _QuickShareRow(
                    accent: _accent,
                    onShareToStory: _shareToStory,
                    onShareToProfile: _shareToProfile,
                    onCopyLink: _copyLink,
                  ),
                  // مستخدمين سريعين (إن وجدوا)
                  if (widget.data.quickShareUsers?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 20),
                    _QuickUsersRow(
                      users: widget.data.quickShareUsers!,
                      accent: _accent,
                      selectedUserId: _selectedQuickUserId,
                      onUserTap: _shareToQuickUser,
                    ),
                  ],
                  const SizedBox(height: 24),
                  // خيارات إضافية
                  _OptionsList(
                    accent: _accent,
                    customOptions: widget.data.customOptions,
                    onCopyLink: _copyLink,
                    onShareExternally: () {
                      // فتح خيارات المشاركة الخارجية (سيتم استدعاؤها عبر Shar نفسها)
                      _showExternalShareSheet();
                    },
                  ),
                  // زر الإلغاء
                  const SizedBox(height: 16),
                  _CancelButton(onTap: () => Navigator.pop(context)),
                ],
              ),
            ),
            // مؤشر المشاركة (يظهر فوق الكل)
            if (_isSharing || _isSuccess) _SharingOverlay(isSuccess: _isSuccess, scale: _scale),
          ]),
        );
      },
    );
  }

  // فتح خيارات مشاركة خارجية (يمكن أن تكون منفصلة)
  void _showExternalShareSheet() {
    // يمكنك هنا فتح Bottom Sheet آخر أو الاعتماد على حزمة share_plus (لكننا نتجنب الخارجية)
    // سنكتفي بعرض SnackBar تجريبية
    _showSnack('External share coming soon');
  }
}

// ═══════════════════════════════════════════════════════════
// مكونات الواجهة (كلها خاصة)
// ═══════════════════════════════════════════════════════════

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 6),
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  final VoidCallback onClose;
  const _Header({required this.onClose});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(children: [
          const Text('Share',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900)),
          const Spacer(),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white12,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded,
                  color: Colors.white60, size: 16),
            ),
          ),
        ]),
      );
}

class _NoteField extends StatelessWidget {
  final TextEditingController noteCtrl;
  final Color accent;
  const _NoteField({required this.noteCtrl, required this.accent});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit_rounded, color: accent, size: 15),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: noteCtrl,
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Write something about this...',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.3), fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ]),
      );
}

class _PreviewCard extends StatelessWidget {
  final ShareData data;
  final Color accent;
  const _PreviewCard({required this.data, required this.accent});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: accent.withOpacity(0.2),
              child: Text(
                data.title.isNotEmpty ? data.title[0].toUpperCase() : '?',
                style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  if (data.subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(data.subtitle!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.5)),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
}

class _QuickShareRow extends StatelessWidget {
  final Color accent;
  final VoidCallback onShareToStory;
  final VoidCallback onShareToProfile;
  final VoidCallback onCopyLink;

  const _QuickShareRow({
    required this.accent,
    required this.onShareToStory,
    required this.onShareToProfile,
    required this.onCopyLink,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickShareIcon(
            icon: Icons.camera_alt_rounded,
            label: 'Story',
            color: const Color(0xFFFF2D55),
            onTap: onShareToStory,
          ),
          _QuickShareIcon(
            icon: Icons.person_rounded,
            label: 'Profile',
            color: accent,
            onTap: onShareToProfile,
          ),
          _QuickShareIcon(
            icon: Icons.chat_rounded,
            label: 'Chat',
            color: const Color(0xFF34C759),
            onTap: () {
              // يمكن فتح قائمة المحادثات أو مشاركة سريعة
              HapticFeedback.selectionClick();
            },
          ),
          _QuickShareIcon(
            icon: Icons.link_rounded,
            label: 'Copy Link',
            color: const Color(0xFFFF9500),
            onTap: onCopyLink,
          ),
        ],
      );
}

class _QuickShareIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickShareIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Column(children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
        ]),
      );
}

class _QuickUsersRow extends StatelessWidget {
  final List<QuickShareUser> users;
  final Color accent;
  final String? selectedUserId;
  final Function(QuickShareUser) onUserTap;

  const _QuickUsersRow({
    required this.users,
    required this.accent,
    required this.selectedUserId,
    required this.onUserTap,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Send',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          SizedBox(
            height: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final user = users[i];
                final isSelected = user.id == selectedUserId;
                return GestureDetector(
                  onTap: () => onUserTap(user),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accent.withOpacity(0.15)
                          : Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? accent.withOpacity(0.5)
                            : Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor:
                            user.color?.withOpacity(0.3) ?? accent.withOpacity(0.2),
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: TextStyle(
                              color: user.color ?? accent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(user.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.send_rounded,
                              size: 14, color: accent),
                        ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      );
}

class _OptionsList extends StatelessWidget {
  final Color accent;
  final List<ShareOption>? customOptions;
  final VoidCallback onCopyLink;
  final VoidCallback onShareExternally;

  const _OptionsList({
    required this.accent,
    this.customOptions,
    required this.onCopyLink,
    required this.onShareExternally,
  });

  @override
  Widget build(BuildContext context) {
    final defaultOptions = <_OptionData>[
      _OptionData(Icons.send_rounded, 'Send via Chat', 'Share directly to a friend',
          () {
        Navigator.pop(context);
        // يمكن فتح نافذة اختيار محادثة
      }),
      _OptionData(Icons.bookmark_border_rounded, 'Save to Collection',
          'Add to your saved items', () {
        Navigator.pop(context);
      }),
      _OptionData(Icons.schedule_rounded, 'Schedule Post',
          'Choose date and time', () {
        Navigator.pop(context);
      }),
      _OptionData(Icons.ios_share_rounded, 'More External Options',
          'WhatsApp, Twitter, etc.', onShareExternally),
      _OptionData(Icons.copy_rounded, 'Copy Link', widget.data.link ?? '',
          onCopyLink),
    ];

    final allOptions = [
      ...defaultOptions,
      if (customOptions != null)
        ...customOptions!.map((opt) => _OptionData(opt.icon, opt.label, '', opt.onTap, color: opt.color)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('More Options',
            style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        ...allOptions.map((opt) => _OptionTile(
              icon: opt.icon,
              label: opt.label,
              sub: opt.sub,
              color: opt.color ?? accent,
              onTap: opt.onTap,
            )),
      ],
    );
  }
}

class _OptionData {
  final IconData icon;
  final String label;
  final String sub;
  final VoidCallback onTap;
  final Color? color;
  _OptionData(this.icon, this.label, this.sub, this.onTap, {this.color});
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.sub,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  if (sub.isNotEmpty)
                    Text(sub,
                        style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Colors.white24, size: 18),
          ]),
        ),
      );
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: const Center(
            child: Text('Cancel',
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      );
}

class _SharingOverlay extends StatelessWidget {
  final bool isSuccess;
  final Animation<double> scale;
  const _SharingOverlay({required this.isSuccess, required this.scale});

  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.85),
          child: Center(
            child: isSuccess
                ? ScaleTransition(
                    scale: scale,
                    child: const Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.check_circle_rounded,
                          color: SharColors.success, size: 64),
                      SizedBox(height: 12),
                      Text('Done!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                    ]),
                  )
                : const Column(mainAxisSize: MainAxisSize.min, children: [
                    CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                    SizedBox(height: 16),
                    Text('Sharing...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14)),
                  ]),
          ),
        ),
      );
}
