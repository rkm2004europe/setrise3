import '../models/track_model.dart';
import '../data/mock_tracks.dart';

class MoodService {
  Future<List<TrackModel>> getTracksForMood(String mood) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockTracks;
  }
}
