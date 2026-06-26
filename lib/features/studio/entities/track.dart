library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';
import 'layer.dart';

part 'track.freezed.dart';
part 'track.g.dart';

enum TrackKind {
  video,
  image,
  effect,
  sticker,
  text,
  music,
  voiceover,
  sfx,
}

extension TrackKindZ on TrackKind {
  int get defaultZ => switch (this) {
        TrackKind.video => 0,
        TrackKind.image => 10,
        TrackKind.effect => 20,
        TrackKind.sticker => 30,
        TrackKind.text => 40,
        TrackKind.music => 50,
        TrackKind.voiceover => 51,
        TrackKind.sfx => 52,
      };

  bool get isAudio =>
      this == TrackKind.music ||
      this == TrackKind.voiceover ||
      this == TrackKind.sfx;

  bool get isVisual => !isAudio;
}

@freezed
class StudioTrack with _$StudioTrack {
  const factory StudioTrack({
    required StudioId id,
    required TrackKind kind,
    @Default('Track') String name,
    @Default(true) bool enabled,
    @Default(1.0) double volume,
    @Default(1.0) double opacity,
    @Default(false) bool locked,
    @Default(false) bool hidden,
    required int z,
    @Default([]) List<StudioId> layerIds,
  }) = _StudioTrack;

  factory StudioTrack.fromJson(Map<String, dynamic> json) =>
      _$StudioTrackFromJson(json);

  const StudioTrack._();

  factory StudioTrack.create({
    required StudioId id,
    required TrackKind kind,
    String name = 'Track',
  }) =>
      StudioTrack(
        id: id,
        kind: kind,
        name: name,
        z: kind.defaultZ,
      );
}
