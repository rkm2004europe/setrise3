library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';

part 'media_source.freezed.dart';
part 'media_source.g.dart';

@freezed
sealed class MediaSource with _$MediaSource {
  const MediaSource._();

  const factory MediaSource.file({
    required StudioId id,
    required String path,
    required String mimeType,
    required Microseconds duration,
    required int width,
    required int height,
    @Default(0) int rotationDegrees,
    @Default(0) int sizeBytes,
    String? thumbnailPath,
    DateTime? createdAt,
  }) = MediaSourceFile;

  const factory MediaSource.asset({
    required StudioId id,
    required String assetKey,
    required String mimeType,
    required Microseconds duration,
    required int width,
    required int height,
  }) = MediaSourceAsset;

  const factory MediaSource.remote({
    required StudioId id,
    required String url,
    required String mimeType,
    required Microseconds duration,
    int? width,
    int? height,
    String? thumbnailUrl,
  }) = MediaSourceRemote;

  const factory MediaSource.generated({
    required StudioId id,
    required GeneratedKind kind,
    required Microseconds duration,
    required int width,
    required int height,
    Map<String, dynamic>? params,
  }) = MediaSourceGenerated;

  factory MediaSource.fromJson(Map<String, dynamic> json) =>
      _$MediaSourceFromJson(json);

  bool get isVideo => mimeType.startsWith('video/') || this is MediaSourceGenerated;
  bool get isImage => mimeType.startsWith('image/');
  bool get isAudioOnly => mimeType.startsWith('audio/');

  StudioId get sourceId => map(
        file: (s) => s.id,
        asset: (s) => s.id,
        remote: (s) => s.id,
        generated: (s) => s.id,
      );

  (int, int) get dimensions => map(
        file: (s) => (s.width, s.height),
        asset: (s) => (s.width, s.height),
        remote: (s) => (s.width ?? 0, s.height ?? 0),
        generated: (s) => (s.width, s.height),
      );

  Microseconds get sourceDuration => map(
        file: (s) => s.duration,
        asset: (s) => s.duration,
        remote: (s) => s.duration,
        generated: (s) => s.duration,
      );
}

enum GeneratedKind {
  solidColor,
  gradient,
  textCard,
  aiAvatar,
  aiVoiceover,
  noise,
}
