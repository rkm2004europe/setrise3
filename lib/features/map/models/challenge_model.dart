class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final double lat;
  final double lng;
  final int reward;
  final DateTime startTime;
  final DateTime endTime;
  final int participantsCount;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.reward,
    required this.startTime,
    required this.endTime,
    this.participantsCount = 0,
  });

  bool get isActive => DateTime.now().isBefore(endTime);
}
