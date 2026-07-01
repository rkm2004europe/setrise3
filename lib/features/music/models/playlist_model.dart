import 'track_model.dart';

class PlaylistModel {
  final String id;
  final String name;
  final String coverEmoji;
  final String creator;
  final int trackCount;
  final List<TrackModel> tracks;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.coverEmoji,
    required this.creator,
    this.trackCount = 0,
    this.tracks = const [],
  });
}
