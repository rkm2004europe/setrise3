class DailyQuestModel {
  final String id;
  final String description;
  final int xpReward;
  final int coinReward;
  final int target;
  int progress;
  bool isCompleted;
  DailyQuestModel({required this.id, required this.description, this.xpReward = 0, this.coinReward = 0, this.target = 1, this.progress = 0, this.isCompleted = false});
}
