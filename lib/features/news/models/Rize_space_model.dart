class RizeSpaceModel {
  final String id;
  final String title;
  final String hostUserId;
  final String hostUserName;
  final List<String> participants;
  final int listenersCount;
  final bool isLive;

  const RizeSpaceModel({
    required this.id,
    required this.title,
    required this.hostUserId,
    required this.hostUserName,
    required this.participants,
    required this.listenersCount,
    required this.isLive,
  });
}
