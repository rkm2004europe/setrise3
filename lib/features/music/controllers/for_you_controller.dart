import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/music_api_service.dart';

class ForYouController extends ChangeNotifier {
  final MusicApiService _service = MusicApiService();
  List<TrackModel> _tracks = [];
  bool _isLoading = false;

  List<TrackModel> get tracks => _tracks;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _tracks = await _service.fetchRecommended();
    _isLoading = false;
    notifyListeners();
  }

  void toggleLike(int index) {
    _tracks[index].isLiked = !_tracks[index].isLiked;
    notifyListeners();
  }
}
