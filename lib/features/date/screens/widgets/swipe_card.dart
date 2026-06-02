// lib/features/date/screens/widgets/swipe_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/date/models/dating_profile_model.dart';

class SwipeCard extends StatefulWidget {
  final DatingProfile profile;
  final bool isTop;
  final VoidCallback onLike;
  final VoidCallback onNope;
  final VoidCallback onSuperLike;

  const SwipeCard({
    super.key,
    required this.profile,
    required this.isTop,
    required this.onLike,
    required this.onNope,
    required this.onSuperLike,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;

  static const double _swipeThreshold = 100;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double get _rotation => _dragOffset.dx / 20;
  double get _opacity  => (1 - (_dragOffset.dx.abs() / 300)).clamp(0.0, 1.0);

  bool get _showLike  => _dragOffset.dx > 40;
  bool get _showNope  => _dragOffset.dx < -40;
  bool get _showSuper => _dragOffset.dy < -60 && _dragOffset.dx.abs() < 60;

  void _onDragStart(DragStartDetails d) {
    if (!widget.isTop) return;
    setState(() => _isDragging = true);
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (!widget.isTop) return;
    setState(() => _dragOffset += d.delta);
  }

  void _onDragEnd(DragEndDetails d) {
    if (!widget.isTop) return;
    final vx = d.velocity.pixelsPerSecond.dx;
    final vy = d.velocity.pixelsPerSecond.dy;

    if (_dragOffset.dx > _swipeThreshold || vx > 800) {
      HapticFeedback.mediumImpact();
      widget.onLike();
    } else if (_dragOffset.dx < -_swipeThreshold || vx < -800) {
      HapticFeedback.mediumImpact();
      widget.onNope();
    } else if (_dragOffset.dy < -_swipeThreshold || vy < -800) {
      HapticFeedback.heavyImpact();
      widget.onSuperLike();
    } else {
      setState(() { _dragOffset = Offset.zero; _isDragging = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isTop) {
      return _buildCard(showOverlay: false);
    }

    return GestureDetector(
      onPanStart: _onDragStart,
      onPanUpdate: _onDragUpdate,
      onPanEnd: _onDragEnd,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: _rotation * 0.0174533,
          child: Opacity(
            opacity: _dragOffset == Offset.zero ? 1.0 : _opacity,
            child: _buildCard(showOverlay: true),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required bool showOverlay}) {
    final p = widget.profile;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 24, offset: const Offset(0, 10))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(fit: StackFit.expand, children: [
          // Photo
          p.photos.isNotEmpty
              ? Image.network(p.photos.first, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _colorFallback(p))
              : _colorFallback(p),

          // Gradient
          Positioned(bottom: 0, left: 0, right: 0, height: 280,
            child: DecoratedBox(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.9)])))),

          // ✅ Swipe indicators
          if (showOverlay && _showLike)
            Positioned(top: 40, left: 20,
              child: _Label(text: '❤️ LIKE', color: const Color(0xFF34C759))),
          if (showOverlay && _showNope)
            Positioned(top: 40, right: 20,
              child: _Label(text: 'NOPE ✕', color: const Color(0xFFFF3B30))),
          if (showOverlay && _showSuper)
            Positioned(top: 40, left: 0, right: 0,
              child: Center(child: _Label(
                  text: '⭐ SUPER', color: const Color(0xFF007AFF)))),

          // Compatibility
          if (p.compatibilityPct > 0)
            Positioned(top: 16, right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2))),
                child: Row(children: [
                  const Text('✨', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text('${p.compatibilityPct}%', style: const TextStyle(
                    color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.w800, fontFamily: 'Inter')),
                ]))),

          // BOOST badge
          if (p.isBoosted)
            Positioned(top: 16, left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(8)),
                child: const Text('🚀 Boosted', style: TextStyle(
                  color: Colors.white, fontSize: 10,
                  fontWeight: FontWeight.w800, fontFamily: 'Inter')))),

          // Info
          Positioned(left: 18, right: 18, bottom: 18,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text('${p.name}, ${p.age}',
                  style: const TextStyle(color: Colors.white, fontSize: 26,
                    fontWeight: FontWeight.w900, fontFamily: 'Inter'))),
                const SizedBox(width: 8),
                if (p.isVerified)
                  const Icon(Icons.verified_rounded,
                      color: Color(0xFF007AFF), size: 22),
                if (p.isOnline) ...[
                  const SizedBox(width: 6),
                  Container(width: 10, height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF34C759), shape: BoxShape.circle)),
                ],
              ]),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.location_on_rounded,
                    color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text('${p.city} · ${p.distanceKm}',
                  style: const TextStyle(color: Colors.white70,
                    fontSize: 13, fontFamily: 'Inter')),
              ]),
              if (p.job != null) ...[
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.work_outline_rounded,
                      color: Colors.white54, size: 14),
                  const SizedBox(width: 4),
                  Text(p.job!, style: const TextStyle(
                    color: Colors.white54, fontSize: 13, fontFamily: 'Inter')),
                ]),
              ],
              const SizedBox(height: 10),
              // Interests chips
              Wrap(spacing: 6, runSpacing: 6,
                children: p.interests.take(4).map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2))),
                  child: Text(tag, style: const TextStyle(
                    color: Colors.white, fontSize: 11,
                    fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                )).toList()),
            ])),
        ]),
      ),
    );
  }

  Widget _colorFallback(DatingProfile p) {
    final colors = [
      const Color(0xFF1A0A2E), const Color(0xFF0A1628),
      const Color(0xFF2E1A0A), const Color(0xFF0A1A0A),
    ];
    final color = colors[p.id.hashCode % colors.length];
    return Container(color: color,
      child: Center(child: Text(p.name[0],
        style: const TextStyle(color: Colors.white, fontSize: 60,
          fontWeight: FontWeight.w900))));
  }
}

class _Label extends StatelessWidget {
  final String text;
  final Color color;
  const _Label({required this.text, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.7), width: 2.5)),
    child: Text(text, style: TextStyle(color: color, fontSize: 16,
      fontWeight: FontWeight.w900, fontFamily: 'Inter')));
}

