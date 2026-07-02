import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/recommendation_service.dart';

class ForYouController extends ChangeNotifier {
  final RecommendationService _service = RecommendationService();
  List<TrackModel> _tracks = [];
  bool _isLoading = false;

  List<TrackModel> get tracks => _tracks;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _tracks = await _service.getRecommended([]);
    _isLoading = false;
    notifyListeners();
  }
}
