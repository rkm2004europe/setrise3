import '../models/event_model.dart';
import '../data/mock_events.dart';

class EventService {
  Future<List<EventModel>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockEvents;
  }
}
