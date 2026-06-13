class ScheduleService {
  final List<Map<String, dynamic>> _scheduled = [];

  void schedule(String conversationId, DateTime at, String text) {
    _scheduled.add({'conv': conversationId, 'at': at, 'text': text});
  }

  List<Map<String, dynamic>> get pending => _scheduled.where((s) => (s['at'] as DateTime).isAfter(DateTime.now())).toList();
}
