library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../commands/editing_commands.dart';
import '../entities/layer.dart';
import '../entities/project.dart';
import '../entities/track.dart';
import '../entities/transform.dart';
import '../state/studio_session.dart';
import '../theme/studio_colors.dart';
import '../utils/typedefs.dart';
import '../widgets/preview_canvas.dart';
import '../widgets/studio_button.dart';
import '../widgets/timeline_widget.dart';
import '../widgets/tool_bar.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _seedIfEmpty());
  }

  void _seedIfEmpty() {
    final session = ref.read(studioSessionProvider);
    if (session.project.tracks.isNotEmpty) return;

    final videoTrackId = 'track_video_main';
    final textTrackId = 'track_text_main';
    final now = DateTime.now();

    final project = session.project.copyWith(
      tracks: [
        StudioTrack.create(
            id: videoTrackId, kind: TrackKind.video, name: 'Video'),
        StudioTrack.create(
            id: textTrackId, kind: TrackKind.text, name: 'Text'),
      ],
      updatedAt: now,
    );
    ref.read(studioSessionProvider.notifier).loadProject(project);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(studioSessionProvider);

    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, session),
            Expanded(child: PreviewCanvas(project: session.project)),
            _buildTransportBar(session),
            SizedBox(
                height: 220,
                child: TimelineWidget(project: session.project)),
            ToolBar(
              selectedLayerId: session.selectedLayerId,
              onAddText: _addTextLayer,
              onAddSticker: _addStickerLayer,
              onSplit: _splitSelected,
              onDelete: _deleteSelected,
              onUndo: ref.read(studioSessionProvider.notifier).undo,
              onRedo: ref.read(studioSessionProvider.notifier).redo,
              canUndo: session.history.canUndo,
              canRedo: session.history.canRedo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, StudioSessionState session) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: StudioSpacing.md, vertical: StudioSpacing.sm),
      child: Row(
        children: [
          StudioButton(
            icon: Icons.close,
            label: '',
            size: StudioButtonSize.medium,
            variant: StudioButtonVariant.secondary,
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          Text(session.project.name,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textPrimary)),
          const Spacer(),
          StudioButton(
            label: 'Export',
            size: StudioButtonSize.medium,
            variant: StudioButtonVariant.primary,
            onPressed: () => context.push('/export'),
          ),
        ],
      ),
    );
  }

  Widget _buildTransportBar(StudioSessionState session) {
    final notifier = ref.read(studioSessionProvider.notifier);
    final duration = session.project.totalDuration;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StudioSpacing.lg),
      child: Row(
        children: [
          Text(_formatTime(session.playhead),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textSecondary,
                  fontFeatures: [FontFeature.tabularFigures()])),
          Expanded(
            child: Slider(
              value: duration == 0
                  ? 0
                  : (session.playhead / duration).clamp(0.0, 1.0),
              onChanged: (v) {
                notifier.setScrubbing(true);
                notifier.setPlayhead((v * duration).round());
              },
              onChangeEnd: (_) => notifier.setScrubbing(false),
            ),
          ),
          Text(_formatTime(duration),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textTertiary,
                  fontFeatures: [FontFeature.tabularFigures()])),
          const SizedBox(width: StudioSpacing.md),
          GestureDetector(
            onTap: () {
              if (session.isPlaying) {
                notifier.pause();
              } else {
                notifier.play();
              }
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: StudioColors.accent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                session.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addTextLayer() {
    final session = ref.read(studioSessionProvider);
    final textTrack = session.project.tracks.firstWhere(
      (t) => t.kind == TrackKind.text,
      orElse: () =>
          StudioTrack.create(id: 'track_text_main', kind: TrackKind.text),
    );

    final layer = TextLayer(
      id: 'text_${DateTime.now().millisecondsSinceEpoch}',
      trackId: textTrack.id,
      text: 'Tap to edit',
      start: session.playhead,
      duration: fromSeconds(3),
      transform:
          const StudioTransform(position: Offset(0.5, 0.8), scale: 1.0),
      preset: StudioTextPreset.tiktokCaption,
    );

    ref
        .read(studioSessionProvider.notifier)
        .execute(AddTextCommand(layer: layer));
  }

  void _addStickerLayer() {
    final session = ref.read(studioSessionProvider);
    final stickerTrack = session.project.tracks.firstWhere(
      (t) => t.kind == TrackKind.sticker,
      orElse: () => StudioTrack.create(
          id: 'track_sticker_main', kind: TrackKind.sticker),
    );

    final layer = StickerLayer(
      id: 'sticker_${DateTime.now().millisecondsSinceEpoch}',
      trackId: stickerTrack.id,
      kind: StickerKind.emoji,
      payload: '🔥',
      start: session.playhead,
      duration: fromSeconds(2),
      transform:
          const StudioTransform(position: Offset(0.5, 0.5), scale: 1.0),
    );

    ref
        .read(studioSessionProvider.notifier)
        .execute(AddStickerCommand(layer: layer));
  }

  void _splitSelected() {
    final session = ref.read(studioSessionProvider);
    final layerId = session.selectedLayerId;
    if (layerId == null) return;
    ref.read(studioSessionProvider.notifier).execute(
          SplitClipCommand(
              layerId: layerId, atMicroseconds: session.playhead),
        );
  }

  void _deleteSelected() {
    final session = ref.read(studioSessionProvider);
    final layerId = session.selectedLayerId;
    if (layerId == null) return;
    ref
        .read(studioSessionProvider.notifier)
        .execute(DeleteLayerCommand(layerId: layerId));
  }

  String _formatTime(Microseconds t) {
    final totalSeconds = t ~/ 1000000;
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
