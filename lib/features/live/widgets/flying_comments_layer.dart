import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/live_comment_model.dart';

class FlyingCommentsLayer extends StatefulWidget {
  final Stream<LiveCommentModel> commentsStream;
  final int maxVisible;

  const FlyingCommentsLayer({
    super.key,
    required this.commentsStream,
    this.maxVisible = 6,
  });

  @override
  State<FlyingCommentsLayer> createState() => _FlyingCommentsLayerState();
}

class _FlyingCommentsLayerState extends State<FlyingCommentsLayer> {
  final List<_FlyingComment> _flying = [];
  late final StreamSubscription<LiveCommentModel> _sub;

  @override
  void initState() {
    super.initState();
    _sub = widget.commentsStream.listen((comment) {
      _addComment(comment);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    for (final fc in _flying) {
      fc.controller.dispose();
    }
    super.dispose();
  }

  void _addComment(LiveCommentModel comment) {
    final controller = AnimationController(
      vsync: TickerProviderImpl(),
      duration: const Duration(seconds: 6),
    );

    final random = Random();
    final startX = random.nextDouble() * 200 - 100; // -100 إلى 100
    final animation = Tween<Offset>(
      begin: Offset(startX, 1.0),
      end: Offset(startX, -1.5),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    final fc = _FlyingComment(comment: comment, controller: controller, animation: animation);

    setState(() {
      _flying.add(fc);
      if (_flying.length > widget.maxVisible) {
        final old = _flying.removeAt(0);
        old.controller.dispose();
      }
    });

    controller.forward().then((_) {
      if (mounted) {
        setState(() {
          _flying.removeWhere((f) => f == fc);
        });
        controller.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: _flying.map((fc) {
          return AnimatedBuilder(
            animation: fc.animation,
            builder: (_, child) {
              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.6 * fc.animation.value.dy + MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.5 + fc.animation.value.dx,
                child: Opacity(
                  opacity: (1.0 - fc.animation.value.dy).clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: fc.comment.isGift
                  ? Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(fc.comment.giftEmoji ?? '🎁', style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 4),
                      Text(fc.comment.userName, style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 13)),
                      const Text(' أرسل هدية', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ])
                  : RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: fc.comment.userName,
                            style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          TextSpan(
                            text: '  ${fc.comment.text}',
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FlyingComment {
  final LiveCommentModel comment;
  final AnimationController controller;
  final Animation<Offset> animation;

  _FlyingComment({required this.comment, required this.controller, required this.animation});
}
