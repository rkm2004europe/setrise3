library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';
import 'layer.dart';
import 'media_source.dart';
import 'track.dart';

part 'project.freezed.dart';
part 'project.g.dart';

enum AspectRatioPreset {
  vertical9x16(9, 16),
  vertical4x5(4, 5),
  square1x1(1, 1),
  horizontal16x9(16, 9),
  horizontal4x3(4, 3);

  final int width;
  final int height;
  const AspectRatioPreset(this.width, this.height);

  double get ratio => width / height;
}

enum ProjectStage {
  draft,
  editing,
  rendering,
  exporting,
  uploading,
  published,
  failed,
}

@freezed
class StudioProject with _$StudioProject {
  const factory StudioProject({
    required StudioId id,
    @Default('Untitled') String name,
    @Default(AspectRatioPreset.vertical9x16)
    AspectRatioPreset aspectRatio,
    @Default(1080) int targetHeight,
    @Default(30) int fps,
    StudioId? masterAudioTrackId,
    @Default([]) List<StudioTrack> tracks,
    @Default([]) List<StudioLayer> layers,
    @Default([]) List<MediaSource> sources,
    Microseconds? duration,
    @Default(ProjectStage.draft) ProjectStage stage,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? coverPath,
    @Default({}) Map<String, dynamic> metadata,
  }) = _StudioProject;

  factory StudioProject.fromJson(Map<String, dynamic> json) =>
      _$StudioProjectFromJson(json);

  const StudioProject._();

  factory StudioProject.create({
    required StudioId id,
    String name = 'Untitled',
    AspectRatioPreset aspectRatio = AspectRatioPreset.vertical9x16,
  }) {
    final now = DateTime.now();
    return StudioProject(
      id: id,
      name: name,
      aspectRatio: aspectRatio,
      createdAt: now,
      updatedAt: now,
    );
  }

  Microseconds get totalDuration => duration ?? _inferredDuration;

  Microseconds get _inferredDuration {
    if (layers.isEmpty) return 0;
    return layers.fold<Microseconds>(
      0,
      (max, l) => l.endMicroseconds > max ? l.endMicroseconds : max,
    );
  }

  List<StudioTrack> get sortedTracks =>
      [...tracks]..sort((a, b) => a.z.compareTo(b.z));

  List<StudioLayer> layersOnTrack(StudioId trackId) =>
      layers.where((l) => l.trackId_ == trackId).toList();

  StudioLayer? layerById(StudioId id) =>
      layers.firstWhereOrNull((l) => l.layerId == id);

  StudioTrack? trackById(StudioId id) =>
      tracks.firstWhereOrNull((t) => t.id == id);

  MediaSource? sourceById(StudioId id) =>
      sources.firstWhereOrNull((s) => s.sourceId == id);
}

extension FirstWhereOrNullExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final item in this) {
      if (test(item)) return item;
    }
    return null;
  }
}
