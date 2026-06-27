library;

import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';

import 'upload_settings.dart';

class UploadJob {
  final String id;
  final File file;
  final UploadSettings settings;

  const UploadJob({
    required this.id,
    required this.file,
    required this.settings,
  });
}

class UploadProgress {
  final double fraction;
  final int bytesSent;
  final int totalBytes;
  final UploadStatus status;

  const UploadProgress({
    required this.fraction,
    required this.bytesSent,
    required this.totalBytes,
    required this.status,
  });
}

enum UploadStatus { queued, uploading, completed, failed, cancelled, paused }

class UploadResult {
  final String responseJson;
  final int statusCode;

  const UploadResult({required this.responseJson, required this.statusCode});
}

class UploadPipeline {
  UploadPipeline();

  final StreamController<UploadProgress> _progressController =
      StreamController<UploadProgress>.broadcast();
  Stream<UploadProgress> get progress => _progressController.stream;

  bool _isInitialised = false;
  final Map<String, UploadTask> _activeTasks = {};

  Future<void> initialize() async {
    if (_isInitialised) return;
    FileDownloader().updates.listen(_handleUpdate);
    _isInitialised = true;
  }

  Future<String> enqueue(UploadJob job) async {
    await initialize();

    final task = UploadTask(
      taskId: job.id,
      url: job.settings.endpoint,
      filename: job.file.uri.pathSegments.last,
      headers: job.settings.headers,
      fields: job.settings.fields ?? {},
      fileField: job.settings.fileFieldName ?? 'file',
      httpRequestMethod: job.settings.method,
      directory: job.file.parent.path,
      baseDirectory: BaseDirectory.root,
      updates: Updates.progressAndStatus,
      retries: job.settings.maxRetries,
      allowCellular: job.settings.allowCellular,
    );

    _activeTasks[job.id] = task;
    await FileDownloader().enqueue(task);

    _progressController.add(UploadProgress(
      fraction: 0,
      bytesSent: 0,
      totalBytes: await job.file.length(),
      status: UploadStatus.queued,
    ));

    return job.id;
  }

  Future<void> cancel(String jobId) async {
    await FileDownloader().cancelTaskWithId(jobId);
    _activeTasks.remove(jobId);
  }

  Future<void> pause(String jobId) async {
    await FileDownloader().pause(taskId: jobId);
  }

  void _handleUpdate(TaskUpdate update) {
    if (update is TaskProgressUpdate) {
      final status = switch (update.status) {
        TaskStatus.running => UploadStatus.uploading,
        TaskStatus.complete => UploadStatus.completed,
        TaskStatus.canceled => UploadStatus.cancelled,
        TaskStatus.failed => UploadStatus.failed,
        TaskStatus.paused => UploadStatus.paused,
        _ => UploadStatus.uploading,
      };
      _progressController.add(UploadProgress(
        fraction: update.progress,
        bytesSent: (update.progress * 1000000).round(),
        totalBytes: 1000000,
        status: status,
      ));
    }
  }

  Future<void> dispose() async {
    await _progressController.close();
  }
}
