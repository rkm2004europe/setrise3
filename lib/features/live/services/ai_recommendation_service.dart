import '../models/live_room_model.dart';
import '../data/mock_live_rooms.dart';

class AiRecommendationService {
  Future<List<LiveRoomModel>> getRecommendations(List<String> interests) async {
    await Future.delayed(const Duration(seconds: 1));
    // محاكاة توصيات بناءً على الاهتمامات
    return mockLiveRooms.where((r) => r.isLive).toList();
  }
}
