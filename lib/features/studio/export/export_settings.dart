/// Render/export configuration.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/project.dart';

part 'export_settings.freezed.dart';
part 'export_settings.g.dart';

enum ExportFormat { mp4H264, mp4H265, mov, webm, gif }

enum ExportQuality {
  draft,    // 480p, low bitrate — fast preview
  standard, // 720p — typical
  high,     // 1080p — recommended
  ultra,    // 2160p — social-ready
}

@freezed
class ExportSettings with _$ExportSettings {
  const factory ExportSettings({
    @Default(ExportFormat.mp4H264) ExportFormat format,
    @Default(ExportQuality.high) ExportQuality quality,
    @Default(30) int fps,
    required AspectRatioPreset aspectRatio,
    @Default(true) bool includeAudio,
    @Default(true) bool includeStickers,
    @Default(true) bool includeText,
    @Default(true) bool includeEffects,
    @Default(8) int videoBitrateMbps,
    @Default(128) int audioBitrateKbps,
    @Default(2) int audioChannels,
    @Default(48000) int audioSampleRate,
    String? outputPathOverride,
    /// Color filter to apply during export (e.g. 'warm', 'cool', 'sepia').
    /// 'none' = no filter. See [FilterRegistry].
    @Default('none') String filterId,
  }) = _ExportSettings;

  factory ExportSettings.fromJson(Map<String, dynamic> json) =>
      _$ExportSettingsFromJson(json);

  const ExportSettings._();

  /// Target height in pixels for the chosen quality.
  int get targetHeightPx => switch (quality) {
        ExportQuality.draft => 480,
        ExportQuality.standard => 720,
        ExportQuality.high => 1080,
        ExportQuality.ultra => 2160,
      };

  /// Target width derived from aspect ratio + height.
  int get targetWidthPx =>
      (targetHeightPx * aspectRatio.ratio).round();
}
