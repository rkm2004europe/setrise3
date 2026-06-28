library;

import 'dart:ui' as ui;

import '../entities/layer.dart';
import '../entities/project.dart';
import '../entities/transform.dart';
import '../utils/typedefs.dart';

sealed class CompositionNode {
  const CompositionNode({
    required this.transform,
    required this.opacity,
    required this.blendMode,
  });

  final StudioTransform transform;
  final double opacity;
  final ui.BlendMode? blendMode;
}

class VideoNode extends CompositionNode {
  const VideoNode({
    required super.transform,
    required super.opacity,
    required super.blendMode,
    required this.sourcePath,
    required this.sourceTimeMicros,
    required this.width,
    required this.height,
    this.filterId,
    this.filterParams = const {},
  });

  final String sourcePath;
  final Microseconds sourceTimeMicros;
  final int width;
  final int height;
  final String? filterId;
  final Map<String, dynamic> filterParams;
}

class ImageNode extends CompositionNode {
  const ImageNode({
    required super.transform,
    required super.opacity,
    required super.blendMode,
    required this.sourcePath,
    required this.width,
    required this.height,
    this.filterId,
  });

  final String sourcePath;
  final int width;
  final int height;
  final String? filterId;
}

class TextNode extends CompositionNode {
  const TextNode({
    required super.transform,
    required super.opacity,
    required super.blendMode,
    required this.text,
    required this.preset,
    required this.hashtags,
    required this.mentions,
  });

  final String text;
  final StudioTextPreset preset;
  final List<String> hashtags;
  final List<String> mentions;
}

class StickerNode extends CompositionNode {
  const StickerNode({
    required super.transform,
    required super.opacity,
    required super.blendMode,
    required this.kind,
    required this.payload,
  });

  final StickerKind kind;
  final String payload;
}

class EffectNode extends CompositionNode {
  const EffectNode({
    required super.transform,
    required super.opacity,
    required super.blendMode,
    required this.effectId,
    required this.params,
  });

  final String effectId;
  final Map<String, dynamic> params;
}

class CompositionFrame {
  final Microseconds time;
  final List<CompositionNode> nodes;
  final int canvasWidth;
  final int canvasHeight;

  const CompositionFrame({
    required this.time,
    required this.nodes,
    required this.canvasWidth,
    required this.canvasHeight,
  });
}

class AudioMixPlan {
  final List<AudioMixItem> items;

  const AudioMixPlan({required this.items});
}

class AudioMixItem {
  final String sourcePath;
  final Microseconds sourceTimeMicros;
  final double volume;
  final bool loop;
  final int fadeInMs;
  final int fadeOutMs;

  const AudioMixItem({
    required this.sourcePath,
    required this.sourceTimeMicros,
    required this.volume,
    required this.loop,
    required this.fadeInMs,
    required this.fadeOutMs,
  });
}

class CompositionEngine {
  CompositionFrame compose(StudioProject project, Microseconds t) {
    final layers = _activeVisualLayers(project, t);
    final nodes = <CompositionNode>[];

    for (final layer in layers) {
      final node = _toNode(layer, t, project);
      if (node != null) nodes.add(node);
    }

    final (w, h) = _canvasDimensions(project);

    return CompositionFrame(
      time: t,
      nodes: nodes,
      canvasWidth: w,
      canvasHeight: h,
    );
  }

  AudioMixPlan audioMixAt(StudioProject project, Microseconds t) {
    final items = <AudioMixItem>[];
    for (final layer in project.layers) {
      if (layer is! AudioLayer && layer is! VideoLayer) continue;
      if (!layer.isActiveAt(t)) continue;

      if (layer is AudioLayer) {
        final source = project.sourceById(layer.source);
        final path = source?.mapOrNull(file: (s) => s.path) ?? '';
        items.add(AudioMixItem(
          sourcePath: path,
          sourceTimeMicros: (t - layer.start) + layer.sourceStart,
          volume: layer.volume,
          loop: layer.loop,
          fadeInMs: layer.fadeInMs,
          fadeOutMs: layer.fadeOutMs,
        ));
      } else if (layer is VideoLayer) {
        final source = project.sourceById(layer.source);
        final path = source?.mapOrNull(file: (s) => s.path) ?? '';
        items.add(AudioMixItem(
          sourcePath: path,
          sourceTimeMicros: (t - layer.start) + layer.sourceStart,
          volume: layer.volume,
          loop: false,
          fadeInMs: 0,
          fadeOutMs: 0,
        ));
      }
    }
    return AudioMixPlan(items: items);
  }

  List<StudioLayer> _activeVisualLayers(
      StudioProject project, Microseconds t) {
    final layers = project.layers.where((l) {
      if (!l.isVisual) return false;
      return l.isActiveAt(t);
    }).toList();

    layers.sort((a, b) {
      final ta = project.trackById(a.trackId_);
      final tb = project.trackById(b.trackId_);
      return (ta?.z ?? 0).compareTo(tb?.z ?? 0);
    });

    return layers;
  }

  CompositionNode? _toNode(
      StudioLayer layer, Microseconds t, StudioProject project) {
    return layer.map(
      video: (l) {
        final source = project.sourceById(l.source);
        final (w, h) = source?.dimensions ?? (0, 0);
        final path = source?.mapOrNull(file: (s) => s.path) ?? '';
        return VideoNode(
          transform: l.transform,
          opacity: l.transform.opacity,
          blendMode: l.transform.blendMode,
          sourcePath: path,
          sourceTimeMicros: (t - l.start) + l.sourceStart,
          width: w,
          height: h,
        );
      },
      image: (l) {
        final source = project.sourceById(l.source);
        final (w, h) = source?.dimensions ?? (0, 0);
        final path = source?.mapOrNull(file: (s) => s.path) ?? '';
        return ImageNode(
          transform: l.transform,
          opacity: l.transform.opacity,
          blendMode: l.transform.blendMode,
          sourcePath: path,
          width: w,
          height: h,
        );
      },
      text: (l) => TextNode(
        transform: l.transform,
        opacity: l.transform.opacity,
        blendMode: l.transform.blendMode,
        text: l.text,
        preset: l.preset,
        hashtags: l.hashtags,
        mentions: l.mentions,
      ),
      sticker: (l) => StickerNode(
        transform: l.transform,
        opacity: l.transform.opacity,
        blendMode: l.transform.blendMode,
        kind: l.kind,
        payload: l.payload,
      ),
      effect: (l) => EffectNode(
        transform: l.transform,
        opacity: l.transform.opacity,
        blendMode: l.transform.blendMode,
        effectId: l.effectId,
        params: l.params,
      ),
      audio: (_) => null,
    );
  }

  (int, int) _canvasDimensions(StudioProject project) {
    final ar = project.aspectRatio;
    final h = project.targetHeight;
    final w = (h * ar.ratio).round();
    return (w, h);
  }
}
