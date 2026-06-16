import '../models/live_audio_room_model.dart';
import '../data/mock_audio_rooms.dart';

class AudioRoomService {
  Future<List<LiveAudioRoomModel>> fetchAudioRooms() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockAudioRooms;
  }
}
