import '../models/voice_room_model.dart';
import '../data/mock_voice_rooms.dart';

class VoiceRoomService {
  Future<List<VoiceRoomModel>> fetchVoiceRooms() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockVoiceRooms;
  }
}
