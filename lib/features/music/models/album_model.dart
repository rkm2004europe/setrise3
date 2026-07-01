import 'track_model.dart';

class AlbumModel {
  final String id;
  final String title;
  final String artist;
  final String coverEmoji;
  final int year;
  final List<TrackModel> tracks;

  AlbumModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverEmoji,
    required this.year,
    required this.tracks,
  });
}
