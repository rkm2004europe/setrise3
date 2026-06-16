class LiveBattleModel {
  final String id;
  final String host1Id;
  final String host2Id;
  final int host1Score;
  final int host2Score;
  final bool isActive;

  LiveBattleModel({
    required this.id,
    required this.host1Id,
    required this.host2Id,
    this.host1Score = 0,
    this.host2Score = 0,
    this.isActive = true,
  });
}
