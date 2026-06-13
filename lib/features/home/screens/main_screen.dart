import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../data/filter_state.dart';
import '../../setrize/screens/set_screen.dart';
import '../../news/screens/rize_feed_screen.dart';
import '../../chat/screens/inbox.dart';
import '../../profile/screens/profile_screen.dart';
import '../../alerts/screens/alerts_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../post/screens/create_hub_screen.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/top_bar.dart';
import '../widgets/pull_down_panel.dart';
import '../widgets/filter_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  
  int _contentTab = 0;
  bool _panelOpen = false;
  late AnimationController _panelCtrl;
  late Animation<double> _panelAnim;
  
  bool _isProcessing = false;
  DateTime _lastInteractionTime = DateTime.now();
  static const Duration _normalDuration = Duration(milliseconds: 260);
  
  Brightness _statusBarBrightness = Brightness.light;
  
  static const _tabLabels = ['SetRize', 'News', 'Chat', 'Profile'];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    _panelCtrl = AnimationController(
      vsync: this,
      duration: _normalDuration,
    );
    _panelAnim = CurvedAnimation(parent: _panelCtrl, curve: Curves.easeOutCubic);
    _panelCtrl.addListener(() => setState(() {}));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStatusBar();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _panelCtrl.dispose();
    super.dispose();
  }

  void _updateStatusBar() {
    final brightness = _panelOpen ? Brightness.dark : Brightness.light;
    if (_statusBarBrightness != brightness) {
      _statusBarBrightness = brightness;
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: _panelOpen ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  Future<void> _safeRun(Future<void> Function() action) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      await action();
    } finally {
      _isProcessing = false;
    }
  }

  void _togglePanel() {
    _safeRun(() async {
      HapticFeedback.mediumImpact();
      if (_panelOpen) {
        await _panelCtrl.reverse();
      } else {
        await _panelCtrl.forward();
      }
      setState(() {
        _panelOpen = !_panelOpen;
        _updateStatusBar();
      });
    });
  }

  void _closePanel() {
    if (!_panelOpen) return;
    _safeRun(() async {
      await _panelCtrl.reverse();
      setState(() {
        _panelOpen = false;
        _updateStatusBar();
      });
    });
  }

  Widget _buildTabNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => _getPageByIndex(index),
        );
      },
    );
  }

  Widget _buildContent() {
    return IndexedStack(
      index: _contentTab,
      children: List.generate(4, (index) => _buildTabNavigator(index)),
    );
  }

  Widget _getPageByIndex(int index) {
    switch (index) {
      case 0: return const SetScreen();
      case 1: return const RizeFeedScreen();
      case 2: return const InboxScreen();
      case 3: return const ProfileScreen();
      default: return const SetScreen();
    }
  }

  void _selectTab(int index) {
    _safeRun(() async {
      if (_contentTab == index) return;
      _closePanel();
      setState(() => _contentTab = index);
      _updateStatusBar();
    });
  }

  void _onNavTap(int i) {
    _safeRun(() async {
      _closePanel();
      
      // 0: Home (SetRize)
      if (i == 0) {
        if (_contentTab == 0) {
          _navigatorKeys[0].currentState?.popUntil((route) => route.isFirst);
          _togglePanel();
        } else {
          HapticFeedback.selectionClick();
          _selectTab(0);
        }
        return;
      }
      
      // 1: Search
      if (i == 1) {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (_) => const SearchScreen()),
        );
        return;
      }

      // 2: Create (+)
      if (i == 2) {
        _showCreateSheet();
        return;
      }

      // 3: Alerts
      if (i == 3) {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (_) => const AlertsScreen()),
        );
        return;
      }

      // 4: Profile
      if (i == 4) {
        _selectTab(3);
        return;
      }
    });
  }

  void _showCreateSheet() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const CreateHubScreen(),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FilterSheet(onApply: () {
        setState(() {});
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _panelOpen ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (_panelOpen) { _closePanel(); return false; }
          final currentNavigator = _navigatorKeys[_contentTab].currentState;
          if (currentNavigator != null && currentNavigator.canPop()) {
            currentNavigator.pop();
            return false;
          }
          if (_contentTab != 0) { _selectTab(0); return false; }
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: const Text('خروج'),
              content: const Text('هل تريد الخروج من التطبيق؟'),
              actions: [
                CupertinoDialogAction(child: const Text('لا'), onPressed: () => Navigator.pop(ctx, false)),
                CupertinoDialogAction(isDestructiveAction: true, child: const Text('نعم'), onPressed: () => Navigator.pop(ctx, true)),
              ],
            ),
          );
          return shouldExit ?? false;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Stack(children: [
            _buildContent(),
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
                      color: Colors.black.withOpacity(0.4 * _panelAnim.value),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: -340 + (340 * _panelAnim.value),
              left: 0, right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! > 15) _closePanel();
                },
                child: PullDownPanel(
                  labels: _tabLabels,
                  activeTab: _contentTab,
                  onTabSelect: (i) { _selectTab(i); _closePanel(); },
                ),
              ),
            ),
            SafeArea(
              child: TopBar(
                panelOpen: _panelOpen,
                onSetRizeTap: _togglePanel,
                onMenuTap: _showFilterSheet,
                activeTabName: _tabLabels[_contentTab],
                showSearchIcon: _contentTab == 0,
                onSearchTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
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
