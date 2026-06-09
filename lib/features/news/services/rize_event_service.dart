import '../models/rize_event_model.dart';
import '../data/mock_rize_events.dart';

class RizeEventService {
  Future<List<RizeEventModel>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockEvents;
  }
}
