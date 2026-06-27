library;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../entities/project.dart';
import '../render/render_pipeline.dart';
import 'export_settings.dart';

class ExportJob {
  final String id;
  final StudioProject project;
  final ExportSettings settings;

  const ExportJob({
    required this.id,
    required this.project,
    required this.settings,
  });
}

class ExportProgress {
  final double fraction;
  final Stage stage;
  final String? message;

  const ExportProgress({
    required this.fraction,
    required this.stage,
    this.message,
  });
}

enum Stage { queued, rendering, postProcessing, finalising, done, failed }

class ExportResult {
  final String outputPath;
  final int sizeBytes;
  final Duration duration;

  const ExportResult({
    required this.outputPath,
    required this.sizeBytes,
    required this.duration,
  });
}

class ExportPipeline {
  ExportPipeline({RenderPipeline? renderPipeline})
      : _renderPipeline = renderPipeline ?? RenderPipeline();

  final RenderPipeline _renderPipeline;

  Stream<ExportProgress> export(ExportJob job,
      {CancellationToken? cancellationToken}) async* {
    final token = cancellationToken ?? CancellationToken();
    if (token.isCancelled) {
      yield const ExportProgress(
          fraction: 0, stage: Stage.failed, message: 'Cancelled');
      return;
    }

    yield const ExportProgress(fraction: 0, stage: Stage.queued);

    final outputDir = await getTemporaryDirectory();
    final outputPath = job.settings.outputPathOverride ??
        p.join(outputDir.path, 'studio_export_${job.id}.mp4');

    final renderJob = RenderJob(
      id: job.id,
      project: job.project,
      settings: job.settings,
      outputPath: outputPath,
    );

    final renderProgress =
        _renderPipeline.render(renderJob, cancellationToken: token);
    await for (final p in renderProgress) {
      if (token.isCancelled) {
        yield const ExportProgress(
            fraction: 0, stage: Stage.failed, message: 'Cancelled');
        return;
      }
      yield ExportProgress(
        fraction: p.fraction * 0.9,
        stage: Stage.rendering,
        message: p.stage.name,
      );
    }

    yield const ExportProgress(fraction: 0.9, stage: Stage.postProcessing);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    yield const ExportProgress(fraction: 0.95, stage: Stage.finalising);
    final file = File(outputPath);
    final size = await file.length();

    yield ExportProgress(
      fraction: 1,
      stage: Stage.done,
      message: outputPath,
    );
  }
}

ExportJob buildExportJob(StudioProject project, ExportSettings settings) =>
    ExportJob(
      id: const Uuid().v4(),
      project: project,
      settings: settings,
    );
