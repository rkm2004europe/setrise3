import '../models/track_model.dart';
import '../data/mock_tracks.dart';

class RecommendationService {
  Future<List<TrackModel>> getRecommended(List<String> genres) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockTracks; // لاحقاً: تصفية حسب النوع
  }
}
