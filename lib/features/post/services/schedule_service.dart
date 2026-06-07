import '../models/draft_model.dart';

class ScheduleService {
  final List<Map<String, dynamic>> _scheduledPosts = [];

  Future<void> schedulePost(DraftModel draft, DateTime scheduledTime) async {
    _scheduledPosts.add({
      'draft': draft,
      'scheduledTime': scheduledTime,
    });
    // TODO: connect to local DB or backend API
  }

  List<Map<String, dynamic>> get pendingScheduledPosts =>
      _scheduledPosts.where((s) => (s['scheduledTime'] as DateTime).isAfter(DateTime.now())).toList();

  Future<void> cancelScheduled(String draftId) async {
    _scheduledPosts.removeWhere((s) => (s['draft'] as DraftModel).id == draftId);
  }
}
