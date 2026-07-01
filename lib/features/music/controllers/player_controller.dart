import 'package:flutter/material.dart';
import '../models/track_model.dart';

class PlayerController extends ChangeNotifier {
  TrackModel? _currentTrack;
  bool _isPlaying = false;

  TrackModel? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;

  void play(TrackModel track) { _currentTrack = track; _isPlaying = true; notifyListeners(); }
  void togglePlay() { _isPlaying = !_isPlaying; notifyListeners(); }
  void stop() { _isPlaying = false; notifyListeners(); }
}
