import '../models/live_room_model.dart';
import '../data/mock_live_rooms.dart';

class LiveApiService {
  Future<List<LiveRoomModel>> fetchLiveRooms({String? category}) async {
    await Future.delayed(const Duration(seconds: 1));
    var rooms = mockLiveRooms.where((r) => r.isLive).toList();
    if (category != null) {
      rooms = rooms.where((r) => r.category == category).toList();
    }
    return rooms;
  }

  Future<LiveRoomModel?> getRoomById(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockLiveRooms.where((r) => r.id == roomId).firstOrNull;
  }
}
