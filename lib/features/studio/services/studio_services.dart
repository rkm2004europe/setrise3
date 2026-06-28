library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ai/face_detection_service.dart';
import '../audio/audio_playback_service.dart';
import '../composition/composition_engine.dart';
import '../drafts/draft_repository.dart';
import '../engine/preview_engine.dart';
import '../export/export_pipeline.dart';
import '../recording/camera_recorder_service.dart';
import '../recording/media_picker_service.dart';
import '../render/render_pipeline.dart';
import '../uploads/upload_pipeline.dart';

/// Top-level facade for the Studio.
///
/// This is a PURE editor service — no social media or live streaming
/// features. It owns the editor engine, recording, export, and upload.
class StudioService {
  StudioService({
    required this.composition,
    required this.preview,
    required this.audioPlayback,
    required this.faceDetection,
    required this.camera,
    required this.mediaPicker,
    required this.drafts,
    required this.render,
    required this.exportPipeline,
    required this.uploads,
  });

  final CompositionEngine composition;
  final PreviewEngine preview;
  final AudioPlaybackService audioPlayback;
  final FaceDetectionService faceDetection;
  final CameraRecorderService camera;
  final MediaPickerService mediaPicker;
  final DraftRepository drafts;
  final RenderPipeline render;
  final ExportPipeline exportPipeline;
  final UploadPipeline uploads;

  /// Eagerly initialise all long-lived services.
  Future<void> initialize() async {
    await drafts.initialize();
    await faceDetection.initialize();
    await camera.initialize();
  }

  /// Dispose everything.
  Future<void> dispose() async {
    preview.dispose();
    await audioPlayback.dispose();
    await faceDetection.dispose();
    await camera.dispose();
    await drafts.dispose();
  }
}

/// Production overrides. Injected in [AppBootstrap.compose].
final List<Override> studioServiceOverrides = [];

/// Provider for [StudioService].
final studioServiceProvider = Provider<StudioService>((ref) {
  final composition = CompositionEngine();
  final audioPlayback = AudioPlaybackService();
  final preview = PreviewEngine(
    composition: composition,
    config: const PreviewConfig(),
    audio: audioPlayback,
  );

  final service = StudioService(
    composition: composition,
    preview: preview,
    audioPlayback: audioPlayback,
    faceDetection: FaceDetectionService(),
    camera: CameraRecorderService(),
    mediaPicker: MediaPickerService(),
    drafts: DraftRepository(),
    render: RenderPipeline(),
    exportPipeline: ExportPipeline(),
    uploads: UploadPipeline(),
  );

  ref.onDispose(service.dispose);
  return service;
});

final List<Override> studioProviderOverrides = [];
