import 'package:flutter/material.dart';
import '../models/track_model.dart';

class HistoryController extends ChangeNotifier {
  final List<TrackModel> _history = [];
  List<TrackModel> get history => _history;

  void addToHistory(TrackModel track) {
    _history.insert(0, track);
    if (_history.length > 100) _history.removeLast();
    notifyListeners();
  }
}
