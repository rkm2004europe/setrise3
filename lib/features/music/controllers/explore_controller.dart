import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../data/mock_tracks.dart';

class ExploreController extends ChangeNotifier {
  String? _selectedCategory;
  List<TrackModel> _tracks = mockTracks;

  String? get selectedCategory => _selectedCategory;
  List<TrackModel> get tracks => _tracks;

  void selectCategory(String? category) {
    _selectedCategory = category;
    _tracks = category == null ? mockTracks : mockTracks.where((t) => t.genres.contains(category)).toList();
    notifyListeners();
  }
}
