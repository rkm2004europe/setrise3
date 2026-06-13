class CallModel {
  final String id;
  final String callerId;
  final String calleeId;
  final bool isVideo;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int durationSeconds;

  CallModel({
    required this.id,
    required this.callerId,
    required this.calleeId,
    required this.isVideo,
    required this.startedAt,
    this.endedAt,
    this.durationSeconds = 0,
  });
}
