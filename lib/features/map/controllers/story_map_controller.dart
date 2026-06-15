import 'package:flutter/material.dart';
import '../models/map_story_model.dart';
import '../services/story_map_service.dart';

class StoryMapController extends ChangeNotifier {
  final StoryMapService _service = StoryMapService();
  List<MapStoryModel> _stories = [];
  List<MapStoryModel> get stories => _stories;

  Future<void> load() async {
    _stories = await _service.fetchStories();
    notifyListeners();
  }
}
