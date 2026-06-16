import 'package:flutter/material.dart';
import '../models/live_audio_room_model.dart';
import '../services/audio_room_service.dart';

class AudioRoomController extends ChangeNotifier {
  final AudioRoomService _service = AudioRoomService();
  List<LiveAudioRoomModel> _rooms = [];
  List<LiveAudioRoomModel> get rooms => _rooms;

  Future<void> load() async {
    _rooms = await _service.fetchAudioRooms();
    notifyListeners();
  }
}
