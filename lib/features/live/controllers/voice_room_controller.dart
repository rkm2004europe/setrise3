import 'package:flutter/material.dart';
import '../models/voice_room_model.dart';
import '../services/voice_room_service.dart';

class VoiceRoomController extends ChangeNotifier {
  final VoiceRoomService _service = VoiceRoomService();
  List<VoiceRoomModel> _rooms = [];
  List<VoiceRoomModel> get rooms => _rooms;

  Future<void> load() async {
    _rooms = await _service.fetchVoiceRooms();
    notifyListeners();
  }
}
