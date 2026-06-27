library;

import 'dart:async';

import '../entities/project.dart';
import '../export/export_settings.dart';
import 'adapters/easy_video_editor_adapter.dart';
import 'adapters/ffmpeg_render_adapter.dart';

class RenderJob {
  final String id;
  final StudioProject project;
  final ExportSettings settings;
  final String outputPath;

  const RenderJob({
    required this.id,
    required this.project,
    required this.settings,
    required this.outputPath,
  });
}

class RenderProgress {
  final double fraction;
  final int currentFrame;
  final int totalFrames;
  final Stage stage;

  const RenderProgress({
    required this.fraction,
    required this.currentFrame,
    required this.totalFrames,
    required this.stage,
  });
}

enum Stage { queuing, analysing, compositing, encoding, finalising, done }

abstract interface class RenderAdapter {
  String get id;
  bool supports(StudioProject project);
  Future<String> render(
    RenderJob job, {
    required void Function(RenderProgress) onProgress,
    required CancellationToken cancellationToken,
  });
}

class CancellationToken {
  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;
  void cancel() => _isCancelled = true;
}

class RenderPipeline {
  RenderPipeline({List<RenderAdapter>? adapters})
      : _adapters = adapters ?? _defaultAdapters();

  final List<RenderAdapter> _adapters;

  RenderAdapter? pickAdapter(StudioProject project) {
    for (final a in _adapters) {
      if (a.supports(project)) return a;
    }
    return null;
  }

  Stream<RenderProgress> render(RenderJob job,
      {CancellationToken? cancellationToken}) async* {
    final adapter = pickAdapter(job.project);
    if (adapter == null) {
      throw StateError('No render adapter supports this project');
    }

    final controller = StreamController<RenderProgress>();
    final token = cancellationToken ?? CancellationToken();

    unawaited(() async {
      try {
        await adapter.render(
          job,
          onProgress: (p) => controller.add(p),
          cancellationToken: token,
        );
        controller.add(const RenderProgress(
          fraction: 1,
          currentFrame: 0,
          totalFrames: 0,
          stage: Stage.done,
        ));
        await controller.close();
      } on Object catch (e, st) {
        controller.addError(e, st);
        await controller.close();
      }
    }());

    yield* controller.stream;
  }

  static List<RenderAdapter> _defaultAdapters() {
    return [
      FFmpegRenderAdapter(),
      EasyVideoEditorAdapter(),
    ];
  }
}
