import '../models/live_history_model.dart';

final List<LiveHistoryModel> mockLiveHistory = [
  LiveHistoryModel(id: 'lh1', hostId: 'h1', title: 'بث الأمس', startedAt: DateTime.now().subtract(const Duration(days: 1)), endedAt: DateTime.now().subtract(const Duration(days: 1)).add(const Duration(hours: 2)), viewers: 320, gifts: 45, earnings: 12.5),
];
