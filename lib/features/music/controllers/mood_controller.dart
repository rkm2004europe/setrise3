import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/mood_service.dart';

class MoodController extends ChangeNotifier {
  final MoodService _service = MoodService();
  List<TrackModel> _tracks = [];
  List<TrackModel> get tracks => _tracks;

  Future<void> loadForMood(String mood) async {
    _tracks = await _service.getTracksForMood(mood);
    notifyListeners();
  }
}
