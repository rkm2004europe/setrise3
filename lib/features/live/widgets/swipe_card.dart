import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';

class SwipeCard extends StatefulWidget {
  final LiveRoomModel room;
  final bool isTop;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;
  final VoidCallback onTap;

  const SwipeCard({
    super.key,
    required this.room,
    required this.isTop,
    required this.onSwipeRight,
    required this.onSwipeLeft,
    required this.onTap,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with SingleTickerProviderStateMixin {
  double _dragX = 0;
  bool _isDragging = false;

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isTop) return;
    setState(() {
      _dragX += details.delta.dx;
      _isDragging = true;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isTop) return;
    final width = MediaQuery.of(context).size.width;
    if (_dragX.abs() > width * 0.3) {
      if (_dragX > 0) {
        widget.onSwipeRight();
      } else {
        widget.onSwipeLeft();
      }
    }
    _resetPosition();
  }

  void _resetPosition() {
    setState(() {
      _dragX = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: LiveColors.surface,
            border: Border.all(color: LiveColors.border),
            boxShadow: _isDragging
                ? [BoxShadow(color: LiveColors.accent.withOpacity(0.5), blurRadius: 20)]
                : null,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 0.7,
                  child: Container(
                    color: LiveColors.surface,
                    child: Center(child: Text(room.thumbnailEmoji ?? '🔴', style: const TextStyle(fontSize: 80))),
                  ),
                ),
              ),
              // معلومات المضيف
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    ),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 18, backgroundColor: LiveColors.accent.withOpacity(0.2), child: Text(room.hostAvatar, style: const TextStyle(fontSize: 18))),
                          const SizedBox(width: 8),
                          Expanded(child: Text(room.hostName, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              const Icon(Icons.visibility, color: Colors.white, size: 12),
                              const SizedBox(width: 4),
                              Text('${room.viewerCount}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(room.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              // مؤشرات السحب
              if (_isDragging) ...[
                if (_dragX > 60)
                  Positioned(top: 40, left: 20, child: Transform.rotate(angle: -0.2, child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                    child: const Text('LIKE', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                  ))),
                if (_dragX < -60)
                  Positioned(top: 40, right: 20, child: Transform.rotate(angle: 0.2, child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: LiveColors.text2, borderRadius: BorderRadius.circular(12)),
                    child: const Text('NEXT', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                  ))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
