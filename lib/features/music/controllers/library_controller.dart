import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/library_service.dart';

class LibraryController extends ChangeNotifier {
  final LibraryService _service = LibraryService();

  List<TrackModel> get likedSongs => _service.likedSongs;
  List<TrackModel> get recentlyPlayed => _service.recentlyPlayed;

  void toggleLike(TrackModel track) { _service.toggleLike(track); notifyListeners(); }
  void addToRecentlyPlayed(TrackModel track) { _service.addToRecentlyPlayed(track); notifyListeners(); }
  bool isLiked(String id) => _service.isLiked(id);
}
