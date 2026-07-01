import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../data/mock_playlists.dart';

class PlaylistController extends ChangeNotifier {
  List<PlaylistModel> _playlists = mockPlaylists;
  List<PlaylistModel> get playlists => _playlists;

  void create(String name) {
    _playlists.add(PlaylistModel(id: 'pl_${DateTime.now().millisecondsSinceEpoch}', name: name, coverEmoji: '🎵', creator: 'You', trackCount: 0));
    notifyListeners();
  }
}
