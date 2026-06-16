class GiveawayModel {
  final String id;
  final String hostId;
  final String prize;
  final int winnersCount;
  final List<String> participants;
  final bool isActive;

  GiveawayModel({
    required this.id,
    required this.hostId,
    required this.prize,
    required this.winnersCount,
    required this.participants,
    this.isActive = true,
  });
}
