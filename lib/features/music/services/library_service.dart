import '../models/track_model.dart';
import '../models/playlist_model.dart';
import '../data/mock_playlists.dart';

class LibraryService {
  final List<TrackModel> _liked = [];
  final List<TrackModel> _recently = [];
  final List<PlaylistModel> _playlists = List.from(mockPlaylists);

  List<TrackModel> get likedSongs => _liked;
  List<TrackModel> get recentlyPlayed => _recently;
  List<PlaylistModel> get playlists => _playlists;

  void toggleLike(TrackModel track) {
    final exists = _liked.any((t) => t.id == track.id);
    if (exists) { _liked.removeWhere((t) => t.id == track.id); } else { _liked.add(track); }
  }

  void removeLiked(String trackId) {
    _liked.removeWhere((t) => t.id == trackId);
  }

  void addToRecentlyPlayed(TrackModel track) {
    _recently.insert(0, track);
    if (_recently.length > 50) _recently.removeLast();
  }

  bool isLiked(String id) => _liked.any((t) => t.id == id);

  void createPlaylist(String name) {
    _playlists.add(PlaylistModel(id: 'pl_${DateTime.now().millisecondsSinceEpoch}', name: name, coverEmoji: '🎵', creator: 'You', trackCount: 0));
  }
}
