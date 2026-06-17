class ViewerChallengeModel {
  final String id;
  final String hostId;
  final String description;
  final int rewardCoins;
  final List<String> acceptedBy;
  final bool isCompleted;
  ViewerChallengeModel({required this.id, required this.hostId, required this.description, required this.rewardCoins, this.acceptedBy = const [], this.isCompleted = false});
}
