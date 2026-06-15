import '../models/map_story_model.dart';
import '../data/mock_map_stories.dart';

class StoryMapService {
  Future<List<MapStoryModel>> fetchStories() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockMapStories.where((s) => !s.isExpired).toList();
  }
}
