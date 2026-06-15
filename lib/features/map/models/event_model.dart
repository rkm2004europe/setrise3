class EventModel {
  final String id;
  final String title;
  final String description;
  final double lat;
  final double lng;
  final DateTime startTime;
  final DateTime endTime;
  final String hostName;
  final int attendeesCount;
  final bool isPublic;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.startTime,
    required this.endTime,
    required this.hostName,
    this.attendeesCount = 0,
    this.isPublic = true,
  });
}
