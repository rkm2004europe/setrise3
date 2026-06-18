import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'host_control_panel.dart';
import 'beauty_filter_slider.dart';
import 'ar_filter_selector.dart';
import 'sound_effects_library.dart';
import 'music_live_track_selector.dart';
import '../screens/viewer_list_sheet.dart';
import '../screens/live_poll_screen.dart';
import '../screens/gift_bundle_shop_screen.dart';

class UnifiedHostDashboard extends StatefulWidget {
  final VoidCallback onEndStream;
  const UnifiedHostDashboard({super.key, required this.onEndStream});

  @override
  State<UnifiedHostDashboard> createState() => _UnifiedHostDashboardState();
}

class _UnifiedHostDashboardState extends State<UnifiedHostDashboard> {
  int _tabIndex = 0;

  static const _tabs = ['تحكم', 'تجميل', 'فلاتر', 'موسيقى', 'صوت', 'المزيد'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: LiveColors.bg.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // التبويبات
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_tabs.length, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _tabIndex = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: _tabIndex == i ? LiveColors.accent : LiveColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        color: _tabIndex == i ? Colors.white : LiveColors.text2,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          // المحتوى
          SizedBox(
            height: 200,
            child: IndexedStack(
              index: _tabIndex,
              children: [
                // تحكم أساسي
                HostControlPanel(
                  onEnd: widget.onEndStream,
                  onSettings: () {},
                  onInvite: () {},
                  onFlipCamera: () {},
                  onToggleFlash: () {},
                  onToggleBeauty: () => setState(() => _tabIndex = 1),
                  onMusic: () => setState(() => _tabIndex = 3),
                ),
                // تجميل
                const BeautyFilterSlider(),
                // فلاتر
                ArFilterSelector(onSelected: (_) {}, selectedFilter: null),
                // موسيقى
                MusicLiveTrackSelector(onTrackSelected: (_) {}),
                // صوت
                SoundEffectsLibrary(onPlay: (_) {}),
                // المزيد
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.people, color: LiveColors.text),
                      title: const Text('المشاهدون', style: TextStyle(color: LiveColors.text)),
                      onTap: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const ViewerListSheet(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.poll, color: LiveColors.text),
                      title: const Text('استفتاء', style: TextStyle(color: LiveColors.text)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LivePollScreen())),
                    ),
                    ListTile(
                      leading: const Icon(Icons.card_giftcard, color: LiveColors.gold),
                      title: const Text('باقات الهدايا', style: TextStyle(color: LiveColors.gold)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftBundleShopScreen())),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
