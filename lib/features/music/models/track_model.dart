class TrackModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverEmoji;
  final Duration duration;
  final String audioUrl;
  final int plays;
  bool isLiked;
  final bool isExplicit;
  final List<String> genres;

  TrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverEmoji,
    required this.duration,
    required this.audioUrl,
    this.plays = 0,
    this.isLiked = false,
    this.isExplicit = false,
    this.genres = const [],
  });
}
