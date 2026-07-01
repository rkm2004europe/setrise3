import '../models/track_model.dart';
import '../data/mock_tracks.dart';

class MusicApiService {
  Future<List<TrackModel>> fetchRecommended() async { await Future.delayed(const Duration(seconds: 1)); return mockTracks; }
  Future<List<TrackModel>> search(String query) async { return mockTracks.where((t) => t.title.toLowerCase().contains(query.toLowerCase())).toList(); }
}
