// lib/features/date/screens/tabs/discover_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/date/models/dating_profile_model.dart';
import 'package:setrise/features/date/screens/widgets/swipe_card.dart';
import 'package:setrise/features/date/screens/widgets/action_buttons.dart';
import 'package:setrise/features/date/screens/widgets/match_overlay.dart';

class DiscoverTab extends StatefulWidget {
  final VoidCallback? onNewMatch;
  const DiscoverTab({super.key, this.onNewMatch});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab>
    with SingleTickerProviderStateMixin {
  late List<DatingProfile> _queue;
  DatingProfile? _matchedProfile;
  bool _showMatch = false;

  late AnimationController _headerCtrl;
  late Animation<Offset>   _headerSlide;

  @override
  void initState() {
    super.initState();
    _queue = List.from(DatingProfile.mockProfiles());
    _headerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))..forward();
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -1.2), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() { _headerCtrl.dispose(); super.dispose(); }

  // ── Actions ──────────────────────────────────────────────
  void _like() {
    if (_queue.isEmpty) return;
    final profile = _queue.first;
    // 30% chance of match
    final isMatch = DateTime.now().millisecond % 3 == 0;
    setState(() => _queue.removeAt(0));
    if (isMatch) {
      setState(() { _matchedProfile = profile; _showMatch = true; });
      widget.onNewMatch?.call();
    }
  }

  void _nope() {
    if (_queue.isEmpty) return;
    setState(() => _queue.removeAt(0));
  }

  void _superLike() {
    if (_queue.isEmpty) return;
    final profile = _queue.first;
    setState(() {
      _queue.removeAt(0);
      _matchedProfile = profile;
      _showMatch = true;
    });
    widget.onNewMatch?.call();
  }

  void _closeMatch() => setState(() { _showMatch = false; _matchedProfile = null; });

  void _openFilter() {
    showModalBottomSheet(context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterSheet(
        onApply: (_, __, ___, ____) {
          setState(() => _queue = List.from(DatingProfile.mockProfiles()));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        // ── App Bar ──────────────────────────────────────
        SlideTransition(position: _headerSlide,
          child: _DatingAppBar(onFilter: _openFilter)),

        const SizedBox(height: 8),

        // ── Card Deck ────────────────────────────────────
        Expanded(child: _queue.isEmpty
          ? _EmptyState(onReset: () => setState(
              () => _queue = List.from(DatingProfile.mockProfiles())))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Back card
                  if (_queue.length > 1)
                    Positioned(top: 14, left: 8, right: 8,
                      bottom: 0,
                      child: Transform.scale(scale: 0.95,
                        child: SwipeCard(
                          profile: _queue[1],
                          isTop: false,
                          onLike: () {}, onNope: () {}, onSuperLike: () {}))),
                  // Top card
                  SwipeCard(
                    key: ValueKey(_queue.first.id),
                    profile: _queue.first,
                    isTop: true,
                    onLike: _like,
                    onNope: _nope,
                    onSuperLike: _superLike,
                  ),
                ],
              ))),

        const SizedBox(height: 16),

        // ── Action Buttons ───────────────────────────────
        if (_queue.isNotEmpty)
          ActionButtons(onNope: _nope, onSuperLike: _superLike, onLike: _like),

        const SizedBox(height: 20),
      ]),

      // ── Match Overlay ────────────────────────────────
      if (_showMatch && _matchedProfile != null)
        Positioned.fill(child: MatchOverlay(
          profile: _matchedProfile!,
          onSendMessage: () {
            _closeMatch();
            // TODO: Navigator.of(context, rootNavigator: true).pushNamed('/chat/${_matchedProfile!.id}')
          },
          onKeepSwiping: _closeMatch,
        )),
    ]);
  }
}

// ════════════════════════════════════════════════════════════
// APP BAR
// ════════════════════════════════════════════════════════════

class _DatingAppBar extends StatelessWidget {
  final VoidCallback onFilter;
  const _DatingAppBar({required this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFFF3B30), Color(0xFFFF6584)]).createShader(b),
          child: const Text('Discover', style: TextStyle(
            color: Colors.white, fontSize: 26,
            fontWeight: FontWeight.w900, fontFamily: 'Inter'))),
        const Spacer(),
        _BarBtn(icon: Icons.tune_rounded,   onTap: onFilter),
        const SizedBox(width: 8),
        _BarBtn(icon: Icons.search_rounded, onTap: () {}),
      ]),
    );
  }
}

class _BarBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _BarBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Container(width: 38, height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Icon(icon, color: Colors.white, size: 20)));
}

// ════════════════════════════════════════════════════════════
// FILTER SHEET
// ════════════════════════════════════════════════════════════

class _FilterSheet extends StatefulWidget {
  final Function(int, int, int, bool) onApply;
  const _FilterSheet({required this.onApply});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  double _maxDist = 100;
  double _ageFrom = 18;
  double _ageTo   = 35;
  bool   _sortInterests = false;

  static const _accent = Color(0xFFFF3B30);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0D0D0D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      padding: EdgeInsets.fromLTRB(20, 16, 20,
        20 + MediaQuery.of(context).padding.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(color: Colors.white24,
            borderRadius: BorderRadius.circular(2))),
        const Text('Filter', style: TextStyle(color: Colors.white, fontSize: 20,
          fontWeight: FontWeight.w900, fontFamily: 'Inter')),
        const SizedBox(height: 24),
        _SliderRow(label: 'Distance', value: _maxDist, min: 5, max: 500, unit: 'km',
          accent: _accent, onChanged: (v) => setState(() => _maxDist = v)),
        const SizedBox(height: 16),
        _RangeRow(label: 'Age Range',
          from: _ageFrom, to: _ageTo, min: 18, max: 60,
          accent: _accent,
          onFromChanged: (v) => setState(() => _ageFrom = v),
          onToChanged:   (v) => setState(() => _ageTo   = v)),
        const SizedBox(height: 16),
        Row(children: [
          const Expanded(child: Text('Sort by shared interests',
            style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter'))),
          Switch(value: _sortInterests, activeColor: _accent,
            onChanged: (v) => setState(() => _sortInterests = v)),
        ]),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            widget.onApply(_maxDist.round(), _ageFrom.round(), _ageTo.round(), _sortInterests);
            Navigator.pop(context);
          },
          child: Container(width: double.infinity, height: 52,
            decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(16)),
            child: const Center(child: Text('Apply Filters', style: TextStyle(
              color: Colors.white, fontSize: 16,
              fontWeight: FontWeight.w800, fontFamily: 'Inter'))))),
      ]),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label, unit;
  final double value, min, max;
  final Color accent;
  final ValueChanged<double> onChanged;
  const _SliderRow({required this.label, required this.value,
    required this.min, required this.max, required this.unit,
    required this.accent, required this.onChanged});

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter')),
      const Spacer(),
      Text('${value.round()} $unit', style: TextStyle(color: accent, fontSize: 14,
        fontWeight: FontWeight.w700, fontFamily: 'Inter')),
    ]),
    Slider(value: value, min: min, max: max, activeColor: accent,
      inactiveColor: Colors.white12, onChanged: onChanged),
  ]);
}

class _RangeRow extends StatelessWidget {
  final String label;
  final double from, to, min, max;
  final Color accent;
  final ValueChanged<double> onFromChanged, onToChanged;
  const _RangeRow({required this.label, required this.from, required this.to,
    required this.min, required this.max, required this.accent,
    required this.onFromChanged, required this.onToChanged});

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter')),
      const Spacer(),
      Text('${from.round()} - ${to.round()}', style: TextStyle(color: accent, fontSize: 14,
        fontWeight: FontWeight.w700, fontFamily: 'Inter')),
    ]),
    RangeSlider(
      values: RangeValues(from, to), min: min, max: max,
      activeColor: accent, inactiveColor: Colors.white12,
      onChanged: (r) { onFromChanged(r.start); onToChanged(r.end); }),
  ]);
}

// ════════════════════════════════════════════════════════════
// EMPTY STATE
// ════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;
  const _EmptyState({required this.onReset});

  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('🎉', style: TextStyle(fontSize: 64)),
      const SizedBox(height: 16),
      const Text("You've seen everyone!", style: TextStyle(
        color: Colors.white, fontSize: 20,
        fontWeight: FontWeight.w800, fontFamily: 'Inter')),
      const SizedBox(height: 8),
      const Text('Check back later for new profiles',
        style: TextStyle(color: Colors.white38, fontSize: 14, fontFamily: 'Inter')),
      const SizedBox(height: 24),
      GestureDetector(onTap: onReset,
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B30),
            borderRadius: BorderRadius.circular(20)),
          child: const Text('Start Over', style: TextStyle(
            color: Colors.white, fontSize: 14,
            fontWeight: FontWeight.w700, fontFamily: 'Inter')))),
    ]));
}
