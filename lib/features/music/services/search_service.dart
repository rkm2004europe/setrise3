Enterimport '../models/track_model.dart';
import '../data/mock_tracks.dart';

class SearchService {
  Future<List<TrackModel>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) return [];
    return mockTracks.where((t) => t.title.toLowerCase().contains(query.toLowerCase()) || t.artist.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
