library;

import 'package:flutter/material.dart';

import '../entities/layer.dart';
import '../entities/project.dart';
import '../entities/track.dart';
import '../theme/studio_colors.dart';
import '../utils/typedefs.dart';

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({
    super.key,
    required this.project,
    this.playhead = 0,
    this.onSeek,
    this.onLayerTap,
    this.pixelsPerSecond = 60,
  });

  final StudioProject project;
  final Microseconds playhead;
  final ValueChanged<Microseconds>? onSeek;
  final ValueChanged<StudioLayer>? onLayerTap;
  final double pixelsPerSecond;

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get _pps => widget.pixelsPerSecond;
  double get _totalWidthPx =>
      (widget.project.totalDuration.seconds * _pps) + 64;

  @override
  Widget build(BuildContext context) {
    final tracks = widget.project.sortedTracks;
    if (tracks.isEmpty) {
      return const Center(
        child: Text('No tracks yet',
            style: TextStyle(color: StudioColors.textTertiary)),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: StudioColors.surface,
        border: Border(
          top: BorderSide(color: StudioColors.separator, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          _buildRuler(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: _totalWidthPx,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          tracks.map((t) => _buildTrack(t)).toList(),
                    ),
                    _buildPlayhead(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuler() {
    final duration = widget.project.totalDuration.seconds;
    final ticks = duration.ceil();
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          for (var i = 0; i <= ticks; i++)
            SizedBox(
              width: _pps,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    '${i}s',
                    style: const TextStyle(
                      fontSize: 9,
                      color: StudioColors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrack(StudioTrack track) {
    final layers = widget.project.layersOnTrack(track.id);
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: StudioSpacing.xs, vertical: 2),
            decoration: BoxDecoration(
              color: StudioColors.surfaceRaised.withOpacity(0.3),
              borderRadius: BorderRadius.circular(StudioRadius.sm),
            ),
          ),
          for (final layer in layers) _buildLayerBlock(layer, track),
        ],
      ),
    );
  }

  Widget _buildLayerBlock(StudioLayer layer, StudioTrack track) {
    final left = layer.startMicroseconds.seconds * _pps;
    final width = layer.durationMicroseconds.seconds * _pps;
    final color = _colorForTrack(track.kind);

    return Positioned(
      left: left + StudioSpacing.xs,
      top: 4,
      bottom: 4,
      width: width - StudioSpacing.xs,
      child: GestureDetector(
        onTap: () => widget.onLayerTap?.call(layer),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.85),
            borderRadius: BorderRadius.circular(StudioRadius.sm),
            border: Border.all(color: color, width: 1),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: _buildLayerLabel(layer),
          ),
        ),
      ),
    );
  }

  Widget _buildLayerLabel(StudioLayer layer) {
    return layer.map(
      video: (l) => const Row(
        children: [
          Icon(Icons.movie, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text('Video',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      image: (l) => const Row(
        children: [
          Icon(Icons.image, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text('Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      text: (l) => Row(
        children: [
          const Icon(Icons.text_fields, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              l.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      sticker: (l) =>
          Row(children: [Text(l.payload, style: const TextStyle(fontSize: 12))]),
      effect: (l) => const Row(
        children: [
          Icon(Icons.auto_awesome, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text('Effect',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      audio: (l) => const Row(
        children: [
          Icon(Icons.graphic_eq, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text('Audio',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPlayhead() {
    final left = widget.playhead.seconds * _pps;
    return Positioned(
      left: left,
      top: 0,
      bottom: 0,
      child: Container(
        width: 2,
        decoration: BoxDecoration(
          color: StudioColors.accent,
          borderRadius: BorderRadius.circular(1),
          boxShadow: const [
            BoxShadow(
                color: Color(0x80FF2D55),
                blurRadius: 4,
                spreadRadius: 1),
          ],
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: const Offset(-5, -2),
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: StudioColors.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForTrack(TrackKind kind) => switch (kind) {
        TrackKind.video => StudioColors.trackVideo,
        TrackKind.image => StudioColors.trackImage,
        TrackKind.text => StudioColors.trackText,
        TrackKind.sticker => StudioColors.trackSticker,
        TrackKind.effect => StudioColors.trackEffect,
        TrackKind.music => StudioColors.trackAudio,
        TrackKind.voiceover => StudioColors.trackAudio,
        TrackKind.sfx => StudioColors.trackAudio,
      };
}
