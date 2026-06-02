// lib/features/live/screens/widgets/live_card.dart

import 'package:flutter/material.dart';
import 'package:setrise/features/live/models/live_stream_model.dart';

class LiveCard extends StatelessWidget {
  final LiveStreamModel stream;
  final VoidCallback onTap;

  const LiveCard({super.key, required this.stream, required this.onTap});

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final isVoice = stream.type == LiveType.voice;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: stream.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(children: [

          // Content
          if (isVoice)
            Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 60, height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3), shape: BoxShape.circle),
                child: const Icon(Icons.mic_rounded, color: Colors.white, size: 32)),
              const SizedBox(height: 8),
              const Text('Voice Room', style: TextStyle(
                color: Colors.white, fontSize: 12, fontFamily: 'Inter')),
            ]))
          else
            Center(child: Icon(Icons.live_tv_rounded,
              color: Colors.white.withOpacity(0.12), size: 60)),

          // 🔴 LIVE badge
          Positioned(top: 8, left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: const Row(children: [
                Icon(Icons.circle, color: Colors.white, size: 6),
                SizedBox(width: 4),
                Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9,
                  fontWeight: FontWeight.w900, fontFamily: 'Inter')),
              ]),
            )),

          // 🔥 HOT badge
          if (stream.isHot)
            Positioned(top: 8, left: 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                child: const Text('🔥 HOT', style: TextStyle(
                  color: Colors.white, fontSize: 9,
                  fontWeight: FontWeight.w700, fontFamily: 'Inter')))),

          // 👥 Viewers
          Positioned(top: 8, right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5)),
              child: Row(children: [
                const Icon(Icons.person_rounded, color: Colors.white, size: 10),
                const SizedBox(width: 3),
                Text(_fmt(stream.viewers), style: const TextStyle(
                  color: Colors.white, fontSize: 10,
                  fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              ]),
            )),

          // Bottom info
          Positioned(bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.85)]),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(stream.title, style: const TextStyle(
                  color: Colors.white, fontSize: 11,
                  fontWeight: FontWeight.w700, fontFamily: 'Inter'),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('@${stream.host} · ${stream.duration}',
                  style: const TextStyle(color: Colors.white54, fontSize: 10,
                    fontFamily: 'Inter')),
              ]),
            )),
        ]),
      ),
    );
  }
}

