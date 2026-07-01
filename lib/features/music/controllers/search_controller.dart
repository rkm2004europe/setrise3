import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/search_service.dart';

class SearchController extends ChangeNotifier {
  final SearchService _service = SearchService();
  List<TrackModel> _results = [];
  List<TrackModel> get results => _results;

  Future<void> search(String query) async {
    _results = await _service.search(query);
    notifyListeners();
  }
}
