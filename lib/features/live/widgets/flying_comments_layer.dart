import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_comment_model.dart';
import '../../user/screens/user_preview_sheet.dart';

class FlyingCommentsLayer extends StatefulWidget {
  final List<LiveCommentModel> comments;
  const FlyingCommentsLayer({super.key, required this.comments});

  @override
  State<FlyingCommentsLayer> createState() => _FlyingCommentsLayerState();
}

class _FlyingCommentsLayerState extends State<FlyingCommentsLayer> with SingleTickerProviderStateMixin {
  final List<_FlyingComment> _flyingComments = [];
  final Random _random = Random();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          for (final fc in _flyingComments) {
            fc.offset -= const Offset(0, 2);
            fc.opacity -= 0.005;
          }
          _flyingComments.removeWhere((fc) => fc.opacity <= 0);
        });
      })
    ..repeat();
    _processComments();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _processComments() {
    if (widget.comments.isEmpty) return;
    // خذ آخر تعليق غير هدية واجعله يطير
    final comment = widget.comments.firstWhere(
      (c) => !c.isGift,
      orElse: () => widget.comments.first,
    );
    final startX = _random.nextDouble() * 200 - 20;
    _flyingComments.add(_FlyingComment(
      userName: comment.userName,
      text: comment.text,
      offset: Offset(startX, 300),
      opacity: 1.0,
      userId: comment.userId,
    ));
    Future.delayed(const Duration(seconds: 5), _processComments);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          children: _flyingComments.map((fc) {
            return Positioned(
              bottom: fc.offset.dy,
              left: fc.offset.dx,
              child: Opacity(
                opacity: fc.opacity.clamp(0.0, 1.0),
                child: GestureDetector(
                  onTap: () {
                    showUserPreviewSheet(
                      context,
                      userId: fc.userId,
                      userName: fc.userName,
                      username: '@${fc.userName}',
                      accent: LiveColors.accent,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${fc.userName} ',
                            style: const TextStyle(
                              color: LiveColors.gold,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: fc.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FlyingComment {
  final String userName;
  final String text;
  final String userId;
  Offset offset;
  double opacity;

  _FlyingComment({
    required this.userName,
    required this.text,
    required this.userId,
    required this.offset,
    required this.opacity,
  });
}
