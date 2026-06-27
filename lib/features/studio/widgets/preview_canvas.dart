library;

import 'package:flutter/material.dart';

import '../composition/composition_engine.dart';
import '../entities/project.dart';
import '../theme/studio_colors.dart';

class PreviewCanvas extends StatelessWidget {
  const PreviewCanvas({
    super.key,
    required this.project,
    this.frame,
  });

  final StudioProject project;
  final CompositionFrame? frame;

  @override
  Widget build(BuildContext context) {
    final ar = project.aspectRatio;
    final size = MediaQuery.of(context).size;
    final maxHeight = size.height - 380;
    final maxWidth = size.width - StudioSpacing.lg * 2;

    var h = maxHeight;
    var w = h * ar.ratio;
    if (w > maxWidth) {
      w = maxWidth;
      h = w / ar.ratio;
    }

    return Center(
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: StudioColors.canvas,
          borderRadius: BorderRadius.circular(StudioRadius.lg),
          border: Border.all(color: StudioColors.separator, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 30,
              spreadRadius: -8,
              offset: Offset(0, 12),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: _CompositionPainter(project: project, frame: frame),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompositionPainter extends CustomPainter {
  _CompositionPainter({required this.project, this.frame});

  final StudioProject project;
  final CompositionFrame? frame;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = StudioColors.canvas,
    );

    final f = frame;
    if (f == null) {
      _drawPlaceholder(canvas, size);
      return;
    }

    for (final node in f.nodes) {
      final rect = _nodeRect(node, size);
      final paint = Paint()
        ..color = _nodeColor(node).withOpacity(node.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
    }
  }

  Rect _nodeRect(CompositionNode node, Size size) {
    final pos = node.transform.position;
    final scale = node.transform.scale;
    final w = size.width * 0.5 * scale;
    final h = size.height * 0.5 * scale;
    return Rect.fromCenter(
      center: Offset(pos.dx * size.width, pos.dy * size.height),
      width: w,
      height: h,
    );
  }

  Color _nodeColor(CompositionNode node) {
    return switch (node) {
      VideoNode() => StudioColors.trackVideo,
      ImageNode() => StudioColors.trackImage,
      TextNode() => StudioColors.trackText,
      StickerNode() => StudioColors.trackSticker,
      EffectNode() => StudioColors.trackEffect,
    };
  }

  void _drawPlaceholder(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = StudioColors.textTertiary.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 32, paint);
  }

  @override
  bool shouldRepaint(covariant _CompositionPainter old) =>
      old.project != project || old.frame != frame;
}
