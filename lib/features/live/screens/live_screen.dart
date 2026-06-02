// lib/features/live/screens/live_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/live/models/live_stream_model.dart';
import 'package:setrise/features/live/screens/widgets/live_card.dart';
import 'package:setrise/features/live/screens/live_room_screen.dart';
import 'package:setrise/features/live/screens/go_live_screen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  String? _selectedCategory;
  final List<LiveStreamModel> _streams = LiveStreamModel.getMockStreams();

  List<LiveStreamModel> get _filtered {
    if (_selectedCategory == null || _selectedCategory == 'All') return _streams;
    return _streams.where((s) => s.category == _selectedCategory).toList();
  }

  void _openRoom(LiveStreamModel stream) {
    HapticFeedback.selectionClick();
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => LiveRoomScreen(stream: stream)));
  }

  void _goLive() {
    HapticFeedback.mediumImpact();
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => const GoLiveScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      // ── Header ─────────────────────────────────────────
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
        child: Row(children: [
          // 🔴 LIVE indicator
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(6)),
            child: const Row(children: [
              Icon(Icons.fiber_manual_record_rounded, color: Colors.white, size: 8),
              SizedBox(width: 4),
              Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 11,
                fontWeight: FontWeight.w900, fontFamily: 'Inter')),
            ])),
          const SizedBox(width: 10),
          Text('${_filtered.length} streams',
            style: const TextStyle(color: Colors.white38, fontSize: 13,
              fontFamily: 'Inter')),
          const Spacer(),
          // Go Live button
          GestureDetector(onTap: _goLive,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: const Row(children: [
                Icon(Icons.videocam_rounded, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text('Go Live', style: TextStyle(color: Colors.white,
                  fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              ]))),
        ])),

      const SizedBox(height: 12),

      // ── Category Filter ────────────────────────────────
      SizedBox(height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          itemCount: LiveStreamModel.categories.length,
          itemBuilder: (_, i) {
            final cat = LiveStreamModel.categories[i];
            final isSelected = (_selectedCategory == null && i == 0)
                || _selectedCategory == cat;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedCategory = i == 0 ? null : cat);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected
                    ? Colors.red : Colors.white.withOpacity(0.12))),
                child: Text(cat, style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontFamily: 'Inter'))));
          })),

      const SizedBox(height: 12),

      // ── Grid ───────────────────────────────────────────
      Expanded(child: _filtered.isEmpty
        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.videocam_off_rounded, size: 64, color: Colors.white24),
            const SizedBox(height: 12),
            const Text('No live streams', style: TextStyle(
              color: Colors.white38, fontSize: 16, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            const Text('Be the first to go live!', style: TextStyle(
              color: Colors.white24, fontSize: 13, fontFamily: 'Inter')),
          ]))
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10,
              mainAxisSpacing: 10, childAspectRatio: 0.78),
            itemCount: _filtered.length,
            itemBuilder: (_, i) => LiveCard(
              stream: _filtered[i],
              onTap: () => _openRoom(_filtered[i])))),
    ]);
  }
}

