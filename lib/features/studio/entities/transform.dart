library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transform.freezed.dart';
part 'transform.g.dart';

@freezed
class StudioTransform with _$StudioTransform {
  const factory StudioTransform({
    @Default(Offset(0.5, 0.5)) Offset position,
    @Default(1.0) double scale,
    @Default(0.0) double rotationDegrees,
    @Default(Offset(0.5, 0.5)) Offset anchor,
    @Default(1.0) double opacity,
    @Default(false) bool flipX,
    @Default(false) bool flipY,
    @Default(null) BlendMode? blendMode,
  }) = _StudioTransform;

  factory StudioTransform.fromJson(Map<String, dynamic> json) =>
      _$StudioTransformFromJson(json);

  const StudioTransform._();

  static const StudioTransform identity = StudioTransform();
}
