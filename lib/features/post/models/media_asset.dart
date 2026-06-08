class MediaAsset {
  final String path;
  final bool isVideo;
  final Duration? duration;

  const MediaAsset({
    required this.path,
    required this.isVideo,
    this.duration,
  });
}
