import '../models/event_model.dart';

final List<EventModel> mockEvents = [
  EventModel(id: 'e1', title: 'حفل موسيقي', description: 'حفل لفنانين محليين', lat: 36.7580, lng: 3.0550, startTime: DateTime.now().add(const Duration(hours: 3)), endTime: DateTime.now().add(const Duration(hours: 6)), hostName: 'نادي الموسيقى', attendeesCount: 200, isPublic: true),
  EventModel(id: 'e2', title: 'مباراة كرة قدم', description: 'فريق الحي ضد فريق الجامعة', lat: 36.7620, lng: 3.0450, startTime: DateTime.now().add(const Duration(hours: 2)), endTime: DateTime.now().add(const Duration(hours: 4)), hostName: 'فريق الأمل', attendeesCount: 50),
];
