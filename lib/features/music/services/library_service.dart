import '../models/track_model.dart';

class LibraryService {
  final List<TrackModel> _liked = [];
  List<TrackModel> get likedSongs => _liked;

  void toggleLike(TrackModel track) {
    final exists = _liked.any((t) => t.id == track.id);
    if (exists) { _liked.removeWhere((t) => t.id == track.id); } else { _liked.add(track); }
  }

  bool isLiked(String id) => _liked.any((t) => t.id == id);
}
