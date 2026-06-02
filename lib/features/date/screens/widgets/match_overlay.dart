// lib/features/date/screens/widgets/match_overlay.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/date/models/dating_profile_model.dart';

class MatchOverlay extends StatefulWidget {
  final DatingProfile profile;
  final VoidCallback onSendMessage;
  final VoidCallback onKeepSwiping;

  const MatchOverlay({
    super.key,
    required this.profile,
    required this.onSendMessage,
    required this.onKeepSwiping,
  });

  @override
  State<MatchOverlay> createState() => _MatchOverlayState();
}

class _MatchOverlayState extends State<MatchOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _scale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade  = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.4)));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade,
      child: Container(
        color: Colors.black.withOpacity(0.88),
        child: SafeArea(child: ScaleTransition(scale: _scale,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // 🎊 Title
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [Color(0xFFFF3B30), Color(0xFFFF6584)],
              ).createShader(b),
              child: const Text("It's a Match! ❤️",
                style: TextStyle(color: Colors.white, fontSize: 34,
                  fontWeight: FontWeight.w900, fontFamily: 'Inter'))),
            const SizedBox(height: 8),
            Text('You and ${widget.profile.name} liked each other!',
              style: const TextStyle(color: Colors.white60, fontSize: 15,
                fontFamily: 'Inter')),
            const SizedBox(height: 40),

            // Avatars
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // My avatar placeholder
              Container(width: 110, height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: Colors.white12),
                child: const Center(child: Text('Me',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,
                    fontSize: 18, fontFamily: 'Inter')))),
              // Heart
              Container(margin: const EdgeInsets.symmetric(horizontal: -10),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B30), shape: BoxShape.circle),
                child: const Icon(Icons.favorite_rounded,
                  color: Colors.white, size: 24)),
              // Match avatar
              Container(width: 110, height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFF3B30), width: 3)),
                child: ClipOval(child: widget.profile.photos.isNotEmpty
                  ? Image.network(widget.profile.photos.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white12,
                        child: Center(child: Text(widget.profile.name[0],
                          style: const TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w900, fontSize: 40)))))
                  : Container(color: Colors.white12))),
            ]),

            const SizedBox(height: 48),

            // ✅ Send Message → يفتح شات التطبيق
            Padding(padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GestureDetector(onTap: widget.onSendMessage,
                child: Container(width: double.infinity, height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF3B30), Color(0xFFFF6584)]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(
                      color: const Color(0xFFFF3B30).withOpacity(0.4),
                      blurRadius: 20, offset: const Offset(0, 8))]),
                  child: const Center(child: Row(
                    mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.chat_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Send Message', style: TextStyle(color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.w800,
                        fontFamily: 'Inter')),
                    ]))))),

            const SizedBox(height: 12),

            // Keep swiping
            GestureDetector(onTap: widget.onKeepSwiping,
              child: const Padding(padding: EdgeInsets.all(14),
                child: Text('Keep Swiping', style: TextStyle(
                  color: Colors.white54, fontSize: 14,
                  fontFamily: 'Inter', fontWeight: FontWeight.w600)))),
          ]))),
      ),
    );
  }
}

