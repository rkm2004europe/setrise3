/// Preview canvas — renders REAL video + text/sticker overlays.
///
/// Uses [VideoPlayer] from the `video_player` package to show the actual
/// video, and overlays [TextLayer] / [StickerLayer] widgets on top using
/// a [Stack]. Overlays are positioned via normalised coordinates (0..1)
/// from [StudioTransform.position].
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../entities/layer.dart';
import '../entities/project.dart';
import '../filters/filter_registry.dart';
import '../theme/studio_colors.dart';
import '../utils/typedefs.dart';

class PreviewCanvas extends StatelessWidget {
  const PreviewCanvas({
    super.key,
    required this.project,
    this.videoController,
    this.playhead = 0,
    this.filterId = 'none',
    this.filterIntensity = 1.0,
  });

  final StudioProject project;
  final VideoPlayerController? videoController;
  final Microseconds playhead;
  final String filterId;
  final double filterIntensity;

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBaseVideo(),
            ..._buildTextOverlays(),
            ..._buildStickerOverlays(),
            // Cinematic top gradient
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 60,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Base video ───────────────────────────────────────────────────────────

  Widget _buildBaseVideo() {
    final controller = videoController;

    if (controller == null || !controller.value.isInitialized) {
      return Container(
        color: StudioColors.canvas,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library_outlined,
                color: StudioColors.textTertiary.withOpacity(0.3),
                size: 48,
              ),
              const SizedBox(height: StudioSpacing.sm),
              Text(
                'No video loaded',
                style: TextStyle(
                  color: StudioColors.textTertiary.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final videoSize = controller.value.size;
    final videoAspect = videoSize.width / videoSize.height;
    final canvasAspect = project.aspectRatio.ratio;

    final videoWidget = FittedBox(
      fit: videoAspect > canvasAspect ? BoxFit.cover : BoxFit.contain,
      child: SizedBox(
        width: videoSize.width,
        height: videoSize.height,
        child: VideoPlayer(controller),
      ),
    );

    // Apply the selected filter via ColorFiltered.matrix
    final filter = FilterRegistry.byId(filterId);
    if (filter != null && filterId != 'none') {
      return ColorFiltered(
        colorFilter: ColorFilter.matrix(filter.colorMatrix.values),
        child: videoWidget,
      );
    }

    return videoWidget;
  }

  // ── Text overlays (with animations) ──────────────────────────────────────

  List<Widget> _buildTextOverlays() {
    final overlays = <Widget>[];

    for (final layer in project.layers) {
      if (layer is! TextLayer) continue;
      if (!layer.isActiveAt(playhead)) continue;

      // Calculate animation progress (0..1) based on time since layer start.
      final elapsedMs = (playhead - layer.startMicroseconds) ~/ 1000;
      const animDurationMs = 300;
      final animProgress = (elapsedMs / animDurationMs).clamp(0.0, 1.0);

      // Apply animation transforms.
      double animOpacity = 1.0;
      double animScale = 1.0;
      double animTranslateY = 0.0;
      var displayText = layer.text;

      switch (layer.preset.animation) {
        case TextAnimationKind.fadeIn:
          animOpacity = animProgress;
        case TextAnimationKind.popIn:
          if (animProgress < 1.0) {
            final t = animProgress;
            animScale = 0.3 + 0.7 * (1.0 - (1.0 - t) * (1.0 - t));
          }
        case TextAnimationKind.slideUp:
          animOpacity = animProgress;
          animTranslateY = 20.0 * (1.0 - animProgress);
        case TextAnimationKind.typewriter:
          if (animProgress < 1.0) {
            final charCount = (layer.text.length * animProgress).round();
            displayText = layer.text.substring(0, charCount);
          }
        case TextAnimationKind.wordByWord:
          if (animProgress < 1.0) {
            final words = layer.text.split(' ');
            final wordCount = (words.length * animProgress).ceil();
            displayText = words.take(wordCount).join(' ');
          }
        case TextAnimationKind.none:
          break;
      }

      overlays.add(
        Positioned.fill(
          child: Align(
            alignment: Alignment(
              layer.transform.position.dx * 2 - 1,
              layer.transform.position.dy * 2 - 1,
            ),
            child: Transform.translate(
              offset: Offset(0, animTranslateY),
              child: Transform.scale(
                scale: layer.transform.scale * animScale,
                child: Transform.rotate(
                  angle: layer.transform.rotationDegrees * 3.14159 / 180,
                  child: Opacity(
                    opacity: layer.transform.opacity * animOpacity,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Stack(
                        children: [
                          // Stroke
                          Text(
                            displayText,
                            textAlign: layer.preset.align,
                            style: TextStyle(
                              fontSize: layer.preset.fontSize,
                              fontWeight: layer.preset.fontWeight,
                              fontFamily: layer.preset.fontFamily,
                              height: layer.preset.height,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = layer.preset.strokeWidth * 2
                                ..color = layer.preset.strokeColor,
                            ),
                          ),
                          // Fill
                          Text(
                            displayText,
                            textAlign: layer.preset.align,
                            style: TextStyle(
                              fontSize: layer.preset.fontSize,
                              fontWeight: layer.preset.fontWeight,
                              fontFamily: layer.preset.fontFamily,
                              height: layer.preset.height,
                              color: layer.preset.color,
                              shadows: layer.preset.shadows,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return overlays;
  }

  // ── Sticker overlays ─────────────────────────────────────────────────────

  List<Widget> _buildStickerOverlays() {
    final overlays = <Widget>[];

    for (final layer in project.layers) {
      if (layer is! StickerLayer) continue;
      if (!layer.isActiveAt(playhead)) continue;

      overlays.add(
        Positioned.fill(
          child: Align(
            alignment: Alignment(
              layer.transform.position.dx * 2 - 1,
              layer.transform.position.dy * 2 - 1,
            ),
            child: Transform.scale(
              scale: layer.transform.scale,
              child: Transform.rotate(
                angle: layer.transform.rotationDegrees * 3.14159 / 180,
                child: Opacity(
                  opacity: layer.transform.opacity,
                  child: switch (layer.kind) {
                    StickerKind.emoji => Text(
                        layer.payload,
                        style: const TextStyle(fontSize: 48),
                      ),
                    StickerKind.gif || StickerKind.png => Image.file(
                        File(layer.payload),
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const SizedBox.shrink(),
                      ),
                    StickerKind.animated => Image.network(
                        layer.payload,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const SizedBox.shrink(),
                      ),
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }

    return overlays;
  }
}
