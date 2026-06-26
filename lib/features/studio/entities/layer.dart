library;

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';
import 'media_source.dart';
import 'transform.dart';

part 'layer.freezed.dart';
part 'layer.g.dart';

@freezed
sealed class StudioLayer with _$StudioLayer {
  const StudioLayer._();

  const factory StudioLayer.video({
    required StudioId id,
    required StudioId trackId,
    required MediaSource source,
    required Microseconds start,
    required Microseconds duration,
    @Default(0) Microseconds sourceStart,
    Microseconds? sourceEnd,
    @Default(1.0) double speed,
    @Default(1.0) double volume,
    required StudioTransform transform,
    String? caption,
  }) = VideoLayer;

  const factory StudioLayer.image({
    required StudioId id,
    required StudioId trackId,
    required MediaSource source,
    required Microseconds start,
    required Microseconds duration,
    required StudioTransform transform,
    @Default(Duration(milliseconds: 300)) Duration inAnimation,
    @Default(Duration(milliseconds: 300)) Duration outAnimation,
  }) = ImageLayer;

  const factory StudioLayer.text({
    required StudioId id,
    required StudioId trackId,
    required String text,
    required Microseconds start,
    required Microseconds duration,
    required StudioTransform transform,
    @Default(StudioTextPreset.defaultPreset) StudioTextPreset preset,
    @Default([]) List<String> hashtags,
    @Default([]) List<String> mentions,
  }) = TextLayer;

  const factory StudioLayer.sticker({
    required StudioId id,
    required StudioId trackId,
    required StickerKind kind,
    required String payload,
    required Microseconds start,
    required Microseconds duration,
    required StudioTransform transform,
  }) = StickerLayer;

  const factory StudioLayer.effect({
    required StudioId id,
    required StudioId trackId,
    required String effectId,
    required Microseconds start,
    required Microseconds duration,
    @Default({}) Map<String, dynamic> params,
    required StudioTransform transform,
  }) = EffectLayer;

  const factory StudioLayer.audio({
    required StudioId id,
    required StudioId trackId,
    required MediaSource source,
    required Microseconds start,
    required Microseconds duration,
    @Default(0) Microseconds sourceStart,
    @Default(1.0) double volume,
    @Default(1.0) double speed,
    @Default(false) bool loop,
    @Default(0) int fadeInMs,
    @Default(0) int fadeOutMs,
  }) = AudioLayer;

  factory StudioLayer.fromJson(Map<String, dynamic> json) =>
      _$StudioLayerFromJson(json);

  StudioId get layerId => map(
        video: (l) => l.id,
        image: (l) => l.id,
        text: (l) => l.id,
        sticker: (l) => l.id,
        effect: (l) => l.id,
        audio: (l) => l.id,
      );

  Microseconds get startMicroseconds => map(
        video: (l) => l.start,
        image: (l) => l.start,
        text: (l) => l.start,
        sticker: (l) => l.start,
        effect: (l) => l.start,
        audio: (l) => l.start,
      );

  Microseconds get durationMicroseconds => map(
        video: (l) => l.duration,
        image: (l) => l.duration,
        text: (l) => l.duration,
        sticker: (l) => l.duration,
        effect: (l) => l.duration,
        audio: (l) => l.duration,
      );

  Microseconds get endMicroseconds =>
      startMicroseconds + durationMicroseconds;

  bool isActiveAt(Microseconds t) =>
      t >= startMicroseconds && t < endMicroseconds;

  bool get isVisual => this is! AudioLayer;

  StudioId get trackId_ => map(
        video: (l) => l.trackId,
        image: (l) => l.trackId,
        text: (l) => l.trackId,
        sticker: (l) => l.trackId,
        effect: (l) => l.trackId,
        audio: (l) => l.trackId,
      );
}

enum StickerKind { emoji, gif, png, animated }

@freezed
class StudioTextPreset with _$StudioTextPreset {
  const factory StudioTextPreset({
    @Default(48) double fontSize,
    @Default(Color(0xFFFFFFFF)) Color color,
    @Default(Color(0xFF000000)) Color strokeColor,
    @Default(2.0) double strokeWidth,
    @Default(null) Color? backgroundColor,
    @Default(TextAlign.center) TextAlign align,
    @Default('SFProDisplay') String fontFamily,
    @Default(FontWeight.w700) FontWeight fontWeight,
    @Default(1.2) double height,
    @Default(null) List<Shadow>? shadows,
    @Default(TextAnimationKind.none) TextAnimationKind animation,
  }) = _StudioTextPreset;

  factory StudioTextPreset.fromJson(Map<String, dynamic> json) =>
      _$StudioTextPresetFromJson(json);

  const StudioTextPreset._();

  static const StudioTextPreset defaultPreset = StudioTextPreset();

  static const StudioTextPreset tiktokCaption = StudioTextPreset(
    fontSize: 42,
    color: Color(0xFFFFFFFF),
    strokeColor: Color(0xFF000000),
    strokeWidth: 3,
    fontWeight: FontWeight.w800,
    animation: TextAnimationKind.popIn,
  );

  static const StudioTextPreset reelsSubtitle = StudioTextPreset(
    fontSize: 36,
    color: Color(0xFFFFD60A),
    strokeColor: Color(0xFF000000),
    strokeWidth: 1.5,
    fontWeight: FontWeight.w700,
    animation: TextAnimationKind.fadeIn,
  );
}

enum TextAnimationKind {
  none,
  fadeIn,
  popIn,
  typewriter,
  slideUp,
  wordByWord,
}
