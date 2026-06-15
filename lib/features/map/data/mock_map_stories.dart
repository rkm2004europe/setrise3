import '../models/map_story_model.dart';

final List<MapStoryModel> mockMapStories = [
  MapStoryModel(
    id: 'ms1', userId: 'u1', userName: 'Ahmed', avatar: '🧑',
    mediaUrl: 'story1', locationName: 'المتحف الوطني', lat: 36.7538, lng: 3.0588,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)), viewsCount: 150,
  ),
  MapStoryModel(
    id: 'ms2', userId: 'u2', userName: 'Sara', avatar: '👩',
    mediaUrl: 'story2', locationName: 'حديقة التجارب', lat: 36.7480, lng: 3.0500,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)), isLive: true,
  ),
];
