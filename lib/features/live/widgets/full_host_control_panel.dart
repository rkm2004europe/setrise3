import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'host_control_panel.dart';
import 'beauty_filter_slider.dart';
import 'ar_filter_selector.dart';
import 'sound_effects_library.dart';

class FullHostControlPanel extends StatefulWidget {
  final VoidCallback onEnd;
  const FullHostControlPanel({super.key, required this.onEnd});

  @override
  State<FullHostControlPanel> createState() => _FullHostControlPanelState();
}

class _FullHostControlPanelState extends State<FullHostControlPanel> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.bg.withOpacity(0.9), borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _tabBtn(0, 'أساسي'),
          _tabBtn(1, 'تجميل'),
          _tabBtn(2, 'فلاتر'),
          _tabBtn(3, 'صوت'),
        ]),
        const SizedBox(height: 10),
        if (_tabIndex == 0) HostControlPanel(onEnd: widget.onEnd, onSettings: () {}, onInvite: () {}, onFlipCamera: () {}, onToggleFlash: () {}, onToggleBeauty: () => setState(() => _tabIndex = 1), onMusic: () => setState(() => _tabIndex = 3)),
        if (_tabIndex == 1) const BeautyFilterSlider(),
        if (_tabIndex == 2) ArFilterSelector(onSelected: (_) {}, selectedFilter: null),
        if (_tabIndex == 3) SoundEffectsLibrary(onPlay: (_) {}),
      ]),
    );
  }

  Widget _tabBtn(int index, String label) => GestureDetector(
    onTap: () => setState(() => _tabIndex = index),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _tabIndex == index ? LiveColors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: TextStyle(color: _tabIndex == index ? Colors.white : LiveColors.text2, fontWeight: FontWeight.w600)),
    ),
  );
}
