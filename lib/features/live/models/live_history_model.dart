class LiveHistoryModel {
  final String id;
  final String hostId;
  final String title;
  final DateTime startedAt;
  final DateTime endedAt;
  final int viewers;
  final int gifts;
  final double earnings;
  final bool isReplayAvailable;
  LiveHistoryModel({required this.id, required this.hostId, required this.title, required this.startedAt, required this.endedAt, this.viewers = 0, this.gifts = 0, this.earnings = 0, this.isReplayAvailable = true});
}
