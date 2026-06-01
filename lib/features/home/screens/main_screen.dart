// lib/features/home/screens/main_screen.dart
//
// ✅ الشاشة الرئيسية — PageView أفقي + TopBar + PullDownPanel
// التنقل: main_navigation_screen.dart يستدعي هذه الشاشة

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Features
import 'package:setrise/features/setrize/screens/setrize_screen.dart';

// Widgets
import 'package:setrise/features/home/screens/widgets/top_bar.dart';
import 'package:setrise/features/home/screens/widgets/bottom_nav.dart';
import 'package:setrise/features/home/screens/widgets/pull_down_panel.dart';
import 'package:setrise/features/home/screens/widgets/create_sheet.dart';

// TODO: أضف باقي الشاشات عند إنشائها
// import 'package:setrise/features/news/screens/news_screen.dart';
// import 'package:setrise/features/shop/screens/shop_screen.dart';
// import 'package:setrise/features/date/screens/date_screen.dart';
// import 'package:setrise/features/live/screens/live_screen.dart';
// import 'package:setrise/features/music/screens/music_screen.dart';
// import 'package:setrise/features/map/screens/map_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  int  _contentTab = 0;
  bool _panelOpen  = false;
  bool _isProcessing = false;

  late AnimationController _panelCtrl;
  late Animation<double>   _panelAnim;
  late PageController      _pageCtrl;

  DateTime _lastInteraction = DateTime.now();
  static const Duration _normalDur = Duration(milliseconds: 260);
  static const Duration _fastDur   = Duration(milliseconds: 150);

  Brightness _statusBarBrightness = Brightness.light;

  static const _tabLabels = [
    'SetRize', 'News', 'Shop', 'Date', 'Live', 'Music', 'Map',
  ];

  // ── الشاشات ────────────────────────────────────────────────
  Widget _getPage(int i) {
    switch (i) {
      case 0: return const SetrizeScreen();
      // TODO: استبدل الـ placeholders بالشاشات الحقيقية
      case 1: return _Placeholder(label: 'News',   color: const Color(0xFF1A2A3A));
      case 2: return _Placeholder(label: 'Shop',   color: const Color(0xFF1A1A2A));
      case 3: return _Placeholder(label: 'Date',   color: const Color(0xFF2A1A1A));
      case 4: return _Placeholder(label: 'Live',   color: const Color(0xFF1A2A1A));
      case 5: return _Placeholder(label: 'Music',  color: const Color(0xFF2A1A2A));
      case 6: return _Placeholder(label: 'Map',    color: const Color(0xFF1A2A2A));
      default: return const SetrizeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageCtrl = PageController(initialPage: _contentTab);
    _panelCtrl = AnimationController(vsync: this, duration: _normalDur);
    _panelAnim = CurvedAnimation(parent: _panelCtrl, curve: Curves.easeOutCubic);
    _panelCtrl.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateStatusBar());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _panelCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _updateStatusBar();
  }

  // ── Status Bar ────────────────────────────────────────────
  void _updateStatusBar() {
    final b = _panelOpen ? Brightness.dark : Brightness.light;
    if (_statusBarBrightness == b) return;
    _statusBarBrightness = b;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _panelOpen ? Brightness.light : Brightness.dark,
      statusBarBrightness:     _panelOpen ? Brightness.dark  : Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  // ── Safe Run ──────────────────────────────────────────────
  Future<void> _safeRun(Future<void> Function() fn) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try { await fn(); } finally { _isProcessing = false; }
  }

  void _updateSpeed() {
    final diff = DateTime.now().difference(_lastInteraction);
    _panelCtrl.duration = diff.inMilliseconds < 200 ? _fastDur : _normalDur;
    _lastInteraction = DateTime.now();
  }

  // ── Panel ─────────────────────────────────────────────────
  void _togglePanel() => _safeRun(() async {
    _updateSpeed();
    HapticFeedback.mediumImpact();
    _panelOpen ? await _panelCtrl.reverse() : await _panelCtrl.forward();
    setState(() { _panelOpen = !_panelOpen; _updateStatusBar(); });
  });

  void _closePanel() {
    if (!_panelOpen) return;
    _safeRun(() async {
      _updateSpeed();
      await _panelCtrl.reverse();
      setState(() { _panelOpen = false; _updateStatusBar(); });
    });
  }

  // ── Tab Navigation ────────────────────────────────────────
  void _selectTab(int i) => _safeRun(() async {
    if (_contentTab == i) return;
    _updateSpeed();
    await _pageCtrl.animateToPage(i,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic);
    setState(() => _contentTab = i);
  });

  // ── Bottom Nav ────────────────────────────────────────────
  void _onNavTap(int i) => _safeRun(() async {
    _closePanel();

    // ➕ Create
    if (i == 2) { _showCreateSheet(); return; }

    // 🏠 Home
    if (i == 4) {
      if (_contentTab == 0) { _togglePanel(); }
      else { HapticFeedback.selectionClick(); _selectTab(0); }
      return;
    }

    // 👤 Profile
    if (i == 3) {
      // TODO: Navigator.of(context, rootNavigator: true).push(...)
      return;
    }

    // 💬 Messages (0) | 🔔 Alerts (1)
    if (i == 0 || i == 1) {
      // TODO: open messages / alerts screens
    }
  });

  // ── Sheets ────────────────────────────────────────────────
  void _showCreateSheet() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => const CreateSheet(),
    );
  }

  // ── PageView ──────────────────────────────────────────────
  Widget _buildContent() {
    return PageView.builder(
      controller: _pageCtrl,
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal),
      onPageChanged: (i) {
        if (_contentTab != i) setState(() => _contentTab = i);
        _closePanel();
      },
      itemCount: _tabLabels.length,
      itemBuilder: (_, i) => AnimatedBuilder(
        animation: _pageCtrl,
        builder: (_, child) {
          double offset = 0;
          if (_pageCtrl.hasClients && _pageCtrl.page != null) {
            offset = (_pageCtrl.page! - i) * 20;
          }
          return Transform.translate(offset: Offset(offset, 0), child: child);
        },
        child: _getPage(i),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _panelOpen ? Brightness.light : Brightness.dark,
        statusBarBrightness:     _panelOpen ? Brightness.dark  : Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (_panelOpen) { _closePanel(); return false; }
          if (_contentTab != 0) { _selectTab(0); return false; }
          final exit = await showDialog<bool>(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: const Text('خروج'),
              content: const Text('هل تريد الخروج من التطبيق؟'),
              actions: [
                CupertinoDialogAction(child: const Text('لا'),
                  onPressed: () => Navigator.pop(ctx, false)),
                CupertinoDialogAction(isDestructiveAction: true,
                  child: const Text('نعم'),
                  onPressed: () => Navigator.pop(ctx, true)),
              ],
            ),
          );
          return exit ?? false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Stack(children: [

            // ── Content ──────────────────────────────────
            _buildContent(),

            // ── Blur Overlay ──────────────────────────────
            if (_panelAnim.value > 0)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closePanel,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: 12.0 * _panelAnim.value,
                      sigmaY: 12.0 * _panelAnim.value,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.4 * _panelAnim.value)),
                  ),
                ),
              ),

            // ── PullDown Panel ────────────────────────────
            Positioned(
              top: -340 + (340 * _panelAnim.value),
              left: 0, right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (d) {
                  if ((d.primaryDelta ?? 0) > 15) _closePanel();
                },
                child: PullDownPanel(
                  labels: _tabLabels,
                  activeTab: _contentTab,
                  onTabSelect: (i) { _selectTab(i); _closePanel(); },
                ),
              ),
            ),

            // ── TopBar ────────────────────────────────────
            SafeArea(
              child: TopBar(
                panelOpen: _panelOpen,
                onSetRizeTap: _togglePanel,
                activeTabName: _tabLabels[_contentTab],
                showSearchIcon: _contentTab == 0,
                onSearchTap: () {
                  // TODO: open search screen
                },
              ),
            ),

            // ── Home Indicator ────────────────────────────
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnimatedOpacity(
                  opacity: _panelOpen ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(width: 140, height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(100))),
                ),
              ),
            ),
          ]),

          bottomNavigationBar: BottomNav(
            onTap: _onNavTap,
            showAlertBadge: true,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// PLACEHOLDER — يُستبدل بالشاشات الحقيقية لاحقاً
// ════════════════════════════════════════════════════════════

class _Placeholder extends StatelessWidget {
  final String label;
  final Color color;
  const _Placeholder({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: Center(child: Text(label,
      style: const TextStyle(color: Colors.white54, fontSize: 24,
        fontWeight: FontWeight.w700, fontFamily: 'Inter'))));
}
