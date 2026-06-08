class MusicTrack {
  final String id;
  final String title;
  final String artist;
  final String? audioUrl;

  const MusicTrack({
    required this.id,
    required this.title,
    required this.artist,
    this.audioUrl,
  });
}
