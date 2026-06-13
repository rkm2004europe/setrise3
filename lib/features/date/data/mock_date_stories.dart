import '../models/date_story_model.dart';

final List<DateStoryModel> mockDateStories = [
  DateStoryModel(id: 'ds1', userId: 'd1', userName: 'سارة', avatar: '🦋', mediaUrls: ['🌸', '🌺'], createdAt: DateTime.now().subtract(const Duration(hours: 2))),
  DateStoryModel(id: 'ds2', userId: 'd2', userName: 'أمين', avatar: '🧑‍💻', mediaUrls: ['🏀', '📖'], createdAt: DateTime.now().subtract(const Duration(hours: 5))),
  DateStoryModel(id: 'ds3', userId: 'd3', userName: 'لينا', avatar: '👩‍⚕️', mediaUrls: ['🎨', '☕'], createdAt: DateTime.now().subtract(const Duration(minutes: 30)), isLive: true),
];
